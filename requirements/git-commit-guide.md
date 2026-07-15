# Git 提交与维护规范

本项目使用 [Conventional Commits](https://www.conventionalcommits.org/) 规范管理提交信息。

## 提交信息格式

```
<type>: <简短描述>

<可选：详细说明>
```

## 类型说明

| 类型       | 使用场景                               | 示例                                                 |
|------------|----------------------------------------|------------------------------------------------------|
| `feat`     | 新增功能 / SQL 查询                     | `feat: add active customer list query`               |
| `fix`      | 修 bug / 修正错误查询逻辑              | `fix: correct rental count join condition`           |
| `refactor` | 重构代码，不改功能                     | `refactor: extract date filter into CTE`             |
| `style`    | 格式化、加空格/缩进，不影响逻辑        | `style: align SELECT columns vertically`             |
| `docs`     | 改文档 / 注释 / Readme                 | `docs: add tasks progress table`                     |
| `chore`    | 杂项：初始化仓库、配置文件等           | `chore: initialize repo with tasks and requirements` |

## 提交原则

1. **一个提交只做一件事** — 改 SQL 就只 add SQL 文件，改文档就只 add 文档文件
2. **描述清楚做了什么** — 不要写 `update file` / `fix bug`
3. **祈使句（命令式）**：`feat: add`、`refactor: improve`、`fix: correct` — 就像在给代码下指令

## 修改流程

```bash
# 1. 查看当前变更
git status

# 2. 暂存需要提交的文件
git add sql/01_active_customer_list.sql

# 3. 提交并按规范写信息
git commit -m "refactor: improve task 1 with CONCAT and table alias"

# 4. 推送
git push
```

## 文件头版本注释规范

每个 SQL 文件头部保留版本日志，方便不看 git 也能追溯。

```sql
--01_active_customer_list
-- v1  [2026-07-15] submitted version
-- v2  [2026-07-15] refine: CONCAT full name, table alias, formatting

use sakila;
...
```

## 查看历史版本

```bash
# 看某次提交改了什么
git show <commit-hash>

# 看某个文件在旧版本的内容
git show <commit-hash>:sql/01_active_customer_list.sql
```

GitHub 网页上点进每次 commit 也能直接看到改前 vs 改后的对比。
