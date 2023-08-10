# CQL

## 简介

### 数据结构

| S.No. | CQL数据类型 | 用法                            |
| :---- | :---------- | :------------------------------ |
| 1.    | boolean     | 用于表示布尔文字：true，false。 |
| 2.    | byte        | 用于表示8位整数。               |
| 3.    | short       | 用于表示16位整数。              |
| 4.    | int         | 用于表示32位整数。              |
| 5.    | long        | 用于表示64位整数。              |
| 6.    | float       | I用于表示32位浮点数。           |
| 7.    | double      | 用于表示64位浮点数。            |
| 8.    | char        | 用于表示16位字符。              |
| 9.    | String      | 用于表示字符串。                |

### 语句

| S.No. | CQL命令/条      | 用法                         |
| :---- | :-------------- | :--------------------------- |
| 1     | CREATE 创建     | 创建节点，关系和属性         |
| 2     | MATCH 匹配      | 检索有关节点，关系和属性数据 |
| 3     | RETURN 返回     | 返回查询结果                 |
| 4     | WHERE 哪里      | 提供条件过滤检索数据         |
| 5     | DELETE 删除     | 删除节点和关系               |
| 6     | REMOVE 移除     | 删除节点和关系的属性         |
| 7     | ORDER BY以…排序 | 排序检索数据                 |
| 8     | SET 组          | 添加或更新标签               |

### 函数

| S.No. | 定制列表功能      | 用法                                           |
| :---- | :---------------- | :--------------------------------------------- |
| 1     | String 字符串     | 它们用于使用String字面量                       |
| 2     | Aggregation 聚合  | 它们用于对CQL查询结果执行一些聚合操作          |
| 3     | Relationship 关系 | 他们用于获取关系的细节，如startnode，endnode等 |



node的id属性是自增的

方向关系

如果我们观察上面的语法，它使用一个箭头标记：（） - []→（）。 它表示从左侧节点到右侧节点的方向。

如果我们尝试使用相同的语法，没有箭头标记like（） - [] - （），这意味着没有方向的关系。 然后Neo4j DB服务器应该抛出一个错误消息



## 语法

### create创建节点和关系

- 创建没有属性的节点
- 使用属性创建节点
- 在没有属性的节点之间创建关系
- 使用属性创建节点之间的关系
- 为节点或关系创建单个或多个标签

```
CREATE (
   <node-name>:<label-name>
   { 	
      <Property1-name>:<Property1-Value>
      ........
      <Propertyn-name>:<Propertyn-Value>
   }
)

# 使用create创建多个，节点可以有多个标签，关系只能是单个标签
CREATE (m:Movie:Cinema:Film:Picture)
```

| 语法元素                                | 描述                                            |
| :-------------------------------------- | :---------------------------------------------- |
| `<node-name>`                           | 它是我们将要创建的节点名称。                    |
| `<label-name>`                          | 它是一个节点标签名称                            |
| `<Property1-name>...<Propertyn-name>`   | 属性是键值对。 定义将分配给创建节点的属性的名称 |
| `<Property1-value>...<Propertyn-value>` | 属性是键值对。 定义将分配给创建节点的属性的值   |

无论节点起什么名字都无所谓，它相当于是python语言里面的一个变量名，指向一个对象，可以对其进行操作。所以节点是可写可不写的，需要操作实例的时候就需要写节点，也可以理解为节点是对应实例的变量名。但是注意标签是一定要写的，标签相当于table名



### match+return查询

**match**

- 从数据库获取有关节点和属性的数据
- 从数据库获取有关节点，关系和属性的数据

match的语法是`match (<node-name>:<label-name>)`，但是match需要和return或其他语句配合使用

记忆：match相当于声明变量名，后续需要用变量名的都要带上match

**return**

```
RETURN 
   <node-name>.<property1-name>,
   ........
   <node-name>.<propertyn-name>
```

**match+return**

- 检索节点的某些属性
- 检索节点的所有属性
- 检索节点和关联关系的某些属性
- 检索节点和关联关系的所有属性

```
# 查询Dept下的内容
MATCH (dept:Dept) return dept

MATCH (dept: Dept)
RETURN dept.deptno,dept.dname

# 查询Employee标签下 id=123，name="Lokesh"的节点
MATCH (p:Employee {id:123,name:"Lokesh"}) 
RETURN p

## 查询Employee标签下name="Lokesh"的节点，使用（where命令）
MATCH (p:Employee)
WHERE p.name = "Lokesh"
RETURN p

match (cc:Customer{name:"Bbc"}) 
return cc

MATCH (cc:CreditCard)-[r]-(c:Customer)
RETURN r 

MATCH ( cc: CreditCard)-[r]-()
RETURN r
```



### 有节点+创建有属性的关系

```
MATCH (<nodel-name>:<node1-label-name>),(<node2-name>:<node2-label-name>)
WHERE <condition>
CREATE  
	(<node1-name>)-[<relationship-name>:<relationship-label-name>{<define-properties-list>}]->(<node2-name>)
RETURN <relationship-name> # 可有可无，有的话立即显示

# {<define-properties-list>}可有可无，有的话有属性
{ 
   <property1-name>:<property1-value>,
   <property2-name>:<property2-value>,
   ...
   <propertyn-name>:<propertyn-value>
}
```

```
MATCH (cust:Customer),(cc:CreditCard) 
CREATE (cust)-[r:DO_SHOPPING_WITH{shopdate:"12/12/2014",price:55000}]->(cc) 
RETURN r

# 创建指定关系
MATCH (cust:Customer),(cc:CreditCard) 
WHERE cust.id = "1001" AND cc.id= "5001" 
CREATE (cust)-[r:DO_SHOPPING_WITH{shopdate:"12/12/2014",price:55000}]->(cc) 
RETURN r
```


| S.No. | 语法元素                    | 描述                                              |
| :---- | :-------------------------- | :------------------------------------------------ |
| 1.    | MATCH,CREATE,RETURN         | 他们是Neo4J CQL关键词。                           |
| 2.    | `<node1-name>`              | 它是用于创建关系的“From Node”的名称。             |
| 3.    | `<node1-label-name>`        | 它是用于创建关系的“From Node”的标签名称。         |
| 4.    | `<node2-name>`              | 它是用于创建关系的“To Node”的名称。               |
| 5.    | `<node2-label-name>`        | 它是用于创建关系的“To Node”的标签名称。           |
| 6.    | `<relationship-name>`       | 这是一个关系的名称。                              |
| 7.    | `<relationship-label-name>` | 它是一个关系的标签名称。                          |
| 8.    | `<define-properties-list>`  | 它是分配给新创建关系的属性（名称 - 值对）的列表。 |



### 无节点+创建有属性的关系

```
# 无属性
CREATE  
   (<node1-name>:<node1-label-name>)-
   [<relationship-name>:<relationship-label-name>]->
   (<node1-name>:<node1-label-name>)
RETURN <relationship-name>

# 有属性
CREATE  
	(<node1-name>:<node1-label-name>{<define-properties-list>})-
	[<relationship-name>:<relationship-label-name>{<define-properties-list>}]
	->(<node1-name>:<node1-label-name>{<define-properties-list>})
RETURN <relationship-name>
```

```
CREATE (fb1:FaceBookProfile1)-[like:LIKES]->(fb2:FaceBookProfile2) 

CREATE (video1:YoutubeVideo1{title:"Action Movie1",updated_by:"Abc",uploaded_date:"10/10/2010"})
-[movie:ACTION_MOVIES{rating:1}]->
(video2:YoutubeVideo2{title:"Action Movie2",updated_by:"Xyz",uploaded_date:"12/12/2012"}) 
```



### where条件判断

boolean运算符：AND, OR, NOT, XOR

比较运算符：=, <>, >, <, >=, <=

```
MATCH (emp:Employee) 
WHERE emp.name = 'Abc' OR emp.name = 'Xyz'
RETURN emp
```



### delete删除节点和关系

Neo4j使用CQL DELETE子句

- 删除节点
- 删除节点及相关节点和关系

```
DELETE <node1-name>,<node2-name>,<relationship-name>

MATCH (cc: CreditCard)-[rel]-(c:Customer) # 单箭头有区别的
DELETE cc,c,rel
```



### remove删除标签和属性

有时基于我们的客户端要求，我们需要向现有节点或关系添加或删除属性。

我们使用Neo4j CQL SET子句向现有节点或关系添加新属性。

我们使用Neo4j CQL REMOVE子句来删除节点或关系的现有属性。

Neo4j CQL REMOVE命令用于

- 删除节点或关系的**标签**
- 删除节点或关系的**属性**

Neo4j CQL DELETE和REMOVE命令之间的主要区别

- DELETE操作用于删除节点和关联关系。
- REMOVE操作用于删除标签和属性。

Neo4j CQL DELETE和REMOVE命令之间的相似性

- 两个命令不应单独使用，都应该与MATCH命令一起使用。

```
# 删除节点属性
REMOVE <property-name-list>
# <property-name-list>
<node-name>.<property1-name>,
<node-name>.<property2-name>, 
.... 
<node-name>.<propertyn-name> 
CREATE (book:Book {id:122,title:"Neo4j Tutorial",pages:340,price:250}) 

MATCH (dc:DebitCard) 
REMOVE dc.cvv
RETURN dc

# 删除节点标签
REMOVE 
# <label-name-list>:
<node-name>:<label2-name>, 
.... 
<node-name>:<labeln-name>

MATCH (m:Movie) 
REMOVE m:Picture
```



### set添加或更新属性

Neo4j CQL 已提供 SET 子句来执行以下操作

- 向现有节点或关系添加新属性
- 添加或更新属性值

```
SET  <property-name-list>

MATCH (book:Book)
SET book.title = 'superstar'
RETURN book
```



### order by排序

Neo4j CQL在MATCH命令中提供了“ORDER BY”子句，对MATCH查询返回的结果进行排序。

我们可以按升序或降序对行进行排序。

默认情况下，它按升序对行进行排序。 如果我们要按降序对它们进行排序，我们需要使用DESC子句

```
MATCH (emp:Employee)
RETURN emp.empid,emp.name,emp.salary,emp.deptno
ORDER BY emp.name DESC
```



### union / union all 合并

union: 它将两组结果中的公共行组合并返回到一组结果中。 它不从两个节点返回重复的行

注意：如果这两个查询不返回相同的列名和数据类型，那么它抛出一个错误。即使两条查询有相同的属性名，但是有不同的节点名称前缀，union仍会显示错误消息，为了避免这种错误，Neo4j的CQL提供“AS”子句

```
# 报错
MATCH (cc:CreditCard) RETURN cc.id,cc.number
UNION
MATCH (dc:DebitCard) RETURN dc.id,dc.number

# 使用AS子句
MATCH (cc:CreditCard)
RETURN cc.id as id,cc.number as number,cc.name as name,
   cc.valid_from as valid_from,cc.valid_to as valid_to
UNION
MATCH (dc:DebitCard)
RETURN dc.id as id,dc.number as number,dc.name as name,
   dc.valid_from as valid_from,dc.valid_to as valid_to
```

union all: 它结合并返回两个结果集的所有行成一个单一的结果集。它还返回由两个节点重复行。



### limit / skip

LIMIT：过滤或限制查询返回的行数。 它修剪CQL查询结果集底部的结果

SKIP：过滤或限制查询返回的行数。 它修整了CQL查询结果集顶部的结果

```
LIMIT <number>
SKIP <number>

MATCH (emp:Employee) 
RETURN emp
LIMIT 2

MATCH (emp:Employee) 
RETURN emp
SKIP 2
```



### merge 合并节点

MERGE命令是CREATE命令和MATCH命令的组合。Neo4j CQL MERGE命令在图中搜索给定模式，如果存在，则返回结果，并不创建新节点。如果它不存在于图中，则它创建新的节点/关系并返回结果

```
MERGE (<node-name>:<label-name>
{
   <Property1-name>:<Property1-Value>
   .....
   <Propertyn-name>:<Propertyn-Value>
})

# on create: 如果找到匹配的节点，那么不会执行ON CREATE子句，也不会修改节点的属性。如果找不到匹配的节点，则将创建该节点
# on match: 更改已经存在于数据库中节点的属性值
MERGE (keanu:Person{name:'keanu Reeves'})
  ON CREATES SET keanu.created = timestamp()
  RETURN keanu.name,keanu.created;

MERGE (person:Person)
  ON MATCH SET person.found = TRUE ,person.lastAccessed = data()
  RETURN person.name,person.found,person.lastAccessed;
```



### IS NULL / IS NOT NULL  判断空值

Neo4j CQL将空值视为对节点或关系的属性的缺失值或未定义值。当我们创建一个具有现有节点标签名称但未指定其属性值的节点时，它将创建一个具有NULL属性值的新节点。

```
MATCH (e:Employee) 
WHERE e.id IS NOT NULL(IS NULL)
RETURN e.id,e.name,e.sal,e.deptno
```



### IN

与SQL一样，Neo4j CQL提供了一个IN运算符，以便为CQL命令提供值的集合

```
MATCH (e:Employee) 
WHERE e.id IN [123,124] # 放在[]里，表示collection of values
RETURN e.id,e.name,e.sal,e.deptno
```



## 聚合

Neo4j CQL提供了一些在RETURN子句中使用的聚合函数。 它类似于SQL中的GROUP BY子句。我们可以使用MATCH命令中的RETURN +聚合函数来处理一组节点并返回一些聚合值

| 聚集功能 | 描述                                    |
| :------- | :-------------------------------------- |
| COUNT    | 它返回由MATCH命令返回的行数。           |
| MAX      | 它从MATCH命令返回的一组行返回最大值。   |
| MIN      | 它返回由MATCH命令返回的一组行的最小值。 |
| SUM      | 它返回由MATCH命令返回的所有行的求和值。 |
| AVG      | 它返回由MATCH命令返回的所有行的平均值。 |

```
MATCH (e:Employee) 
RETURN e.id,e.name,e.sal,e.deptno # 查询4行结果
MATCH (e:Employee) RETURN COUNT(*) # 返回4行

MATCH (e:Employee) 
RETURN MAX(e.sal),MIN(e.sal) # 返回4行中的最大值和最小值

```



## 关系函数

Neo4j CQL提供了一组关系函数，以在获取开始节点，结束节点等细节时知道关系的细节

| 功能      | 描述                                     |
| :-------- | :--------------------------------------- |
| STARTNODE | 它用于知道关系的开始节点。               |
| ENDNODE   | 它用于知道关系的结束节点。               |
| ID        | 它用于知道关系的ID。                     |
| TYPE      | 它用于知道字符串表示中的一个关系的TYPE。 |

```
# 查找开始节点
MATCH (a)-[movie:ACTION_MOVIES]->(b) 
RETURN STARTNODE(movie)

# 查找结束节点
MATCH (a)-[movie:ACTION_MOVIES]->(b) 
RETURN ENDNODE(movie)

# ID和TYPE关系函数来检索关系的Id和类型详细信息
# type就是标签名
MATCH (a)-[movie:ACTION_MOVIES]->(b) 
RETURN ID(movie),TYPE(movie)
```





## 函数

### 字符串函数

| 功能      | 描述                             |
| :-------- | :------------------------------- |
| UPPER     | 它用于将所有字母更改为大写字母。 |
| LOWER     | 它用于将所有字母改为小写字母。   |
| SUBSTRING | 它用于获取给定String的子字符串。 |
| REPLACE   | 它用于替换一个字符串的子字符串。 |
|           |                                  |
|           |                                  |

```
MATCH (e:Employee) 
RETURN e.id,UPPER(e.name),e.sal,e.deptno

# 在Neo4J CQL中，如果一个字符串包含n个字母，则它的长度为n，索引从0开始，到n-1结束。
# <startIndex>是SUBSTRING函数的索引值。
# <endIndex>是可选的。 如果我们省略它，那么它返回给定字符串的子串从startIndex到字符串的结尾
# 包括startIndex，但是不包括endIndex
SUBSTRING(<input-string>,<startIndex> ,<endIndex>)
```



# 常用功能汇总

```
CALL db.schema.visualization(); # 查看节点和关系

MATCH (c1:Client)-[:HAS_EMAIL|:HAS_PHONE|:HAS_SSN]->(n) <-[:HAS_EMAIL|:HAS_PHONE|:HAS_SSN]-(c2:Client)
WHERE id(c1) < id(c2)
RETURN c1.id, c2.id, count(*) AS freq
ORDER BY freq DESC;

MATCH (c1:Client)-[:HAS_EMAIL|:HAS_PHONE|:HAS_SSN]->(n) <-[:HAS_EMAIL|:HAS_PHONE|:HAS_SSN]-(c2:Client)
WHERE id(c1) <> id(c2)
RETURN count(DISTINCT c1.id) AS freq;

MATCH (c1:Client)-[:HAS_EMAIL|:HAS_PHONE|:HAS_SSN] ->(n)<- [:HAS_EMAIL|:HAS_PHONE|:HAS_SSN]-(c2:Client)
WHERE id(c1) < id(c2)
WITH c1, c2, count(*) as cnt
MERGE (c1) - [:SHARED_IDENTIFIERS {count: cnt}] -> (c2);

#----------------------------------------
match (n) detach delete n # 删除全部节点

match (n:Client{name: "Bbc"}) detach delete n # 删除节点及其关系
```



# UNIQUE约束

Unique约束的优点

- 避免重复记录
- 强制执行数据完整性规则

```
CREATE CONSTRAINT ON (<label_name>)
ASSERT <property_name> IS UNIQUE
DROP CONSTRAINT ON (<label_name>)
ASSERT <property_name> IS UNIQUE

CREATE CONSTRAINT ON (cc:CreditCard)
ASSERT cc.number IS UNIQUE
# 此时如果cc.number包含重复值会报错
MATCH (cc:CreditCard) 
WHERE cc.number = 222222
DELETE cc

CREATE CONSTRAINT ON (cc:CreditCard)
ASSERT cc.number IS UNIQUE
# 之后再插入number重复值会报错

# drop unique constraint
DROP CONSTRAINT ON (cc:CreditCard)
ASSERT cc.number IS UNIQUE

```





# 索引

Neo4j SQL支持节点或关系属性上的索引，以提高应用程序的性能。

我们可以为具有相同标签名称的所有节点的属性创建索引。

我们可以在MATCH或WHERE或IN运算符上使用这些索引列来改进CQL Command的执行

```
CREATE INDEX ON :<label_name> (<property_name>)
DROP INDEX ON :<label_name> (<property_name>)

CREATE INDEX ON :Customer (name) # 在CreditCard节点的name属性上创建INDEX
DROP INDEX ON :Customer (name)



```



[www.baidu.com](baidu)









Neo4j 管理员

Neo4j数据库备份和恢复
