# Sakila SQL 实战练习

---
不得不说，手撕十道题目之后不用动不动就翻笔记了。

顺带一提，这 10 道题也是 AI 基于我实际的 Sakila 数据库结构生成的——相当于需求文档是 AI 写的，解法讨论也是跟 AI 一边聊一边出来的，我主要负责拆需求、选方案、判断对错。

## 记录

### 第 5 题 · 门店最佳员工

这道题卡了最久，不是因为语法不懂，而是**翻译需求**的过程不顺畅。需求是「每个门店经手总金额最高的员工」，这其实是两个层级的聚合：

- 先算每个员工在各自门店的总额
- 再从每个门店里挑出最大的那个

GROUP BY 的粒度也踩了一次坑。一开始写了 `GROUP BY staff_name`，不同门店的同名员工会被合并成一行。需要加上 `store_id` 和 `staff_id` 才能保证唯一。

解法试了两种：
- 关联子查询：跟同门店的人比 max
- LEFT JOIN 派生表：先算每个门店的 max 值，再匹配回来

两种都能跑，关键是要意识到问题本身有两层聚合。

---

### 第 7 题 · 门店周转效率

从 rental 表到 store_id 其实有两条路：`rental → staff → store` 和 `rental → inventory → store`。两条路语法上都跑得通，但语义不一样——一个按员工归属算，一个按碟片归属算。

数据词典告诉你怎么连表，但口径怎么定要跟业务方沟通，所以以后遇到问题结合实际情况就行，不管他
---

### 第 8 题 · 全类别忠实客户

核心是关系除法。先知道总共有多少个类别，再算每个人下过多少种不同类别，两个数字相等就是全品类覆盖。`HAVING count = 总数` 一行搞定，比一开始构思的递归 CTE 逐一检查简单得多。

---

### 第 9 题 · 累计消费曲线

第一次用到窗口函数。`SUM() OVER(PARTITION BY customer_id ORDER BY payment_date)` 实现 running total。

跑 EXPLAIN 发现 `Using temporary; Using filesort`。查了一下是窗口函数执行器的内部流程——它需要把数据按 PARTITION 和 ORDER 的规则重新排列才能计算。加了索引之后依然存在，不是优化能解决的。不过 Sakila 数据量很小，实际感受不到性能影响，所以不管他。

---

### 第 10 题 · 全库存不可用作品

最复杂的一题。需要找出「在所有门店中所有库存都不可用」的作品，我自己分析的话，不可用有两种情况：
- 根本就没有库存
- 有库存但每一张都被借出去了

第一种用 LEFT JOIN + IS NULL（复用第 4 题的思路），第二种需要比较总库存数和已借出数，相等说明全在外面。

两个条件用 OR 组合，需要多个 CTE 配合：一个管零库存，一个算总库存，一个算已借出，一个做筛选。这道题把 CTE 的组织和拆分能力练了一遍。

---

### 整体感受

10 道题做下来，最大的收获不是某个新函数或新语法，而是逐渐建立起一种**拆解需求**的思维习惯：

1. 输出什么字段？每行代表什么？
2. 数据链路怎么走？
3. 需要几层转换？
4. 过滤是行级的还是聚合后的？

呃呃其实是终于记住一些语法了以前动不动就要去翻obsidian的笔记。

---

## 项目说明

### 简介

基于 MySQL Sakila 示例数据库的 SQL 实战练习，共 10 道题，覆盖简单到较难的业务场景。

### 数据库

使用 MySQL 官方提供的 [Sakila 示例数据库](https://dev.mysql.com/doc/sakila/en/)，模拟了一家 DVD 租赁店的业务数据。

### 文件结构

```
├── sql/                          # SQL 查询文件
│   ├── 01_active_customer_list.sql
│   ├── 02_category_works_count.sql
│   ├── 03_monthly_revenue_report.sql
│   ├── 04_orders_no_payment_customers.sql
│   ├── 05_top_employee_by_store.sql
│   ├── 06_top10_rented_works_revenue.sql
│   ├── 07_store_avg_order_cycle.sql
│   ├── 08_all_category_customers.sql
│   ├── 09_customer_cumulative_consumption.sql
│   └── 10_unavailable_inventory_all_stores.sql
├── requirements/                  # 需求文档
│   ├── data_dictionary.md
│   ├── tasks.md
│   ├── sql_files_list.md
│   └── git-commit-guide.md
└── Readme.md
```

### 使用方式

```bash
mysql -u root -p sakila < sql/05_top_employee_by_store.sql
```

### Commit 规范

本项目使用 Conventional Commits，详见 `requirements/git-commit-guide.md`。
