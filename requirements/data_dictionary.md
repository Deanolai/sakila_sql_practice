# Sakila 数据字典

> 多媒体内容发行企业业务系统 — 数据库表结构说明

---

## actor — 参演艺人

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| actor_id | SMALLINT UNSIGNED | NO | PRI | 艺人唯一编号，自增主键 |
| first_name | VARCHAR(45) | NO | | 艺人的名（名字） |
| last_name | VARCHAR(45) | NO | MUL | 艺人的姓，该列建有索引 |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

---

## address — 地址

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| address_id | SMALLINT UNSIGNED | NO | PRI | 地址唯一编号，自增主键 |
| address | VARCHAR(50) | NO | | 街道地址（第一行） |
| address2 | VARCHAR(50) | YES | | 街道地址（第二行），可选 |
| district | VARCHAR(20) | NO | | 区/县 |
| city_id | SMALLINT UNSIGNED | NO | MUL | 所属城市编号，关联 city 表 |
| postal_code | VARCHAR(10) | YES | | 邮政编码 |
| phone | VARCHAR(20) | NO | | 联系电话 |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

---

## category — 内容类别

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| category_id | TINYINT UNSIGNED | NO | PRI | 类别唯一编号，自增主键 |
| name | VARCHAR(25) | NO | | 类别名称（如 Action、Comedy、Drama 等） |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

---

## city — 城市

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| city_id | SMALLINT UNSIGNED | NO | PRI | 城市唯一编号，自增主键 |
| city | VARCHAR(50) | NO | | 城市名称 |
| country_id | SMALLINT UNSIGNED | NO | MUL | 所属国家编号，关联 country 表 |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

---

## country — 国家

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| country_id | SMALLINT UNSIGNED | NO | PRI | 国家唯一编号，自增主键 |
| country | VARCHAR(50) | NO | | 国家名称 |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

---

## customer — 客户

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| customer_id | SMALLINT UNSIGNED | NO | PRI | 客户唯一编号，自增主键 |
| store_id | TINYINT UNSIGNED | NO | MUL | 所属门店编号，关联 store 表 |
| first_name | VARCHAR(45) | NO | | 客户的名 |
| last_name | VARCHAR(45) | NO | MUL | 客户的姓，该列建有索引 |
| email | VARCHAR(50) | YES | | 电子邮箱地址 |
| address_id | SMALLINT UNSIGNED | NO | MUL | 地址编号，关联 address 表 |
| active | BOOLEAN | NO | | 账户状态：**1 = 启用**，**0 = 禁用** |
| create_date | DATETIME | NO | | 客户注册时间 |
| last_update | TIMESTAMP | YES | | 该条记录最后被修改的时间 |

---

## film — 作品（内容产品）

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| film_id | SMALLINT UNSIGNED | NO | PRI | 作品唯一编号，自增主键 |
| title | VARCHAR(128) | NO | MUL | 作品标题 |
| description | TEXT | YES | | 作品简介/剧情描述 |
| release_year | YEAR | YES | | 发布年份 |
| language_id | TINYINT UNSIGNED | NO | MUL | 原始语种编号，关联 language 表 |
| original_language_id | TINYINT UNSIGNED | YES | MUL | 译制的原始语种编号（若为译制片），关联 language 表 |
| rental_duration | TINYINT UNSIGNED | NO | | 标准租期（天），默认 3 天 |
| rental_rate | DECIMAL(4,2) | NO | | 标准租借单价，默认 4.99 |
| length | SMALLINT UNSIGNED | YES | | 作品时长（分钟） |
| replacement_cost | DECIMAL(5,2) | NO | | 丢失/损坏后的重置赔偿价格，默认 19.99 |
| rating | ENUM('G','PG','PG-13','R','NC-17') | YES | | 内容分级，默认 'G'，各取值含义见下方说明 |
| special_features | SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') | YES | | 作品附带特别收录内容，可为多个值（逗号分隔） |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

**rating 枚举取值含义：**

| 取值 | 含义 |
|------|------|
| G | 普遍级，适合所有观众 |
| PG | 建议家长指导 |
| PG-13 | 13 岁以下需家长陪同 |
| R | 限制级，17 岁以下需成人陪同 |
| NC-17 | 仅限 17 岁及以上 |

**special_features 多选值说明：**

| 取值 | 含义 |
|------|------|
| Trailers | 预告片 |
| Commentaries | 评论音轨 |
| Deleted Scenes | 删减片段 |
| Behind the Scenes | 幕后花絮 |

---

## film_actor — 作品-艺人关联

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| actor_id | SMALLINT UNSIGNED | NO | PRI | 艺人编号，联合主键一部分，关联 actor 表 |
| film_id | SMALLINT UNSIGNED | NO | PRI/MUL | 作品编号，联合主键一部分，关联 film 表 |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

---

## film_category — 作品-类别关联

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| film_id | SMALLINT UNSIGNED | NO | PRI | 作品编号，联合主键一部分，关联 film 表 |
| category_id | TINYINT UNSIGNED | NO | PRI | 类别编号，联合主键一部分，关联 category 表 |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

---

## film_text — 作品全文搜索

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| film_id | SMALLINT | NO | PRI | 作品编号，对应 film 表 film_id |
| title | VARCHAR(255) | NO | | 作品标题（冗余存储，通过触发器从 film 表同步） |
| description | TEXT | YES | | 作品简介（冗余存储，通过触发器从 film 表同步） |

> 该表通过触发器自动与 film 表保持同步，专用于全文搜索（FULLTEXT 索引在 title 和 description 上）。

---

## inventory — 库存

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| inventory_id | MEDIUMINT UNSIGNED | NO | PRI | 库存品唯一编号，自增主键 |
| film_id | SMALLINT UNSIGNED | NO | MUL | 作品编号，关联 film 表 |
| store_id | TINYINT UNSIGNED | NO | MUL | 所属门店编号，关联 store 表 |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

> 同一作品在同一个门店可以有多个库存副本（多条 inventory 记录）。

---

## language — 语种

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| language_id | TINYINT UNSIGNED | NO | PRI | 语种唯一编号，自增主键 |
| name | CHAR(20) | NO | | 语种名称（如 English、Chinese 等） |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

---

## payment — 付款/收入记录

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| payment_id | SMALLINT UNSIGNED | NO | PRI | 付款记录唯一编号，自增主键 |
| customer_id | SMALLINT UNSIGNED | NO | MUL | 付款客户编号，关联 customer 表 |
| staff_id | TINYINT UNSIGNED | NO | MUL | 经手员工编号，关联 staff 表 |
| rental_id | INT | YES | | 关联的订单编号，关联 rental 表（可为空，对应历史数据） |
| amount | DECIMAL(5,2) | NO | | 付款金额 |
| payment_date | DATETIME | NO | | 付款时间 |
| last_update | TIMESTAMP | YES | | 该条记录最后被修改的时间 |

---

## rental — 订单（借出记录）

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| rental_id | INT | NO | PRI | 订单唯一编号，自增主键 |
| rental_date | DATETIME | NO | UNI | 订单创建时间（借出时间），与 inventory_id、customer_id 组成联合唯一约束 |
| inventory_id | MEDIUMINT UNSIGNED | NO | MUL | 借出的库存品编号，关联 inventory 表 |
| customer_id | SMALLINT UNSIGNED | NO | MUL | 客户编号，关联 customer 表 |
| return_date | DATETIME | YES | | 实际归还时间，**NULL 表示尚未归还** |
| staff_id | TINYINT UNSIGNED | NO | MUL | 经手员工编号，关联 staff 表 |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

---

## staff — 员工

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| staff_id | TINYINT UNSIGNED | NO | PRI | 员工唯一编号，自增主键 |
| first_name | VARCHAR(45) | NO | | 员工的名 |
| last_name | VARCHAR(45) | NO | | 员工的姓 |
| address_id | SMALLINT UNSIGNED | NO | MUL | 地址编号，关联 address 表 |
| picture | BLOB | YES | | 员工照片（二进制数据） |
| email | VARCHAR(50) | YES | | 电子邮箱地址 |
| store_id | TINYINT UNSIGNED | NO | MUL | 所属门店编号，关联 store 表 |
| active | BOOLEAN | NO | | 在职状态：**1 = 在职**，**0 = 离职** |
| username | VARCHAR(16) | NO | | 系统登录用户名 |
| password | VARCHAR(40) | YES | | 密码（SHA-1 哈希加密，区分大小写） |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |

---

## store — 门店/分公司

| 字段名 | 数据类型 | 可为空 | 键类型 | 业务含义 |
|--------|----------|--------|--------|----------|
| store_id | TINYINT UNSIGNED | NO | PRI | 门店唯一编号，自增主键 |
| manager_staff_id | TINYINT UNSIGNED | NO | UNI | 门店经理的员工编号，关联 staff 表，一个员工只能担任一家门店的经理 |
| address_id | SMALLINT UNSIGNED | NO | MUL | 门店地址编号，关联 address 表 |
| last_update | TIMESTAMP | NO | | 该条记录最后被修改的时间 |
