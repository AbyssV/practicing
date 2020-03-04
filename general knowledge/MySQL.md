Ensuring that any one transaction (when run all by itself) preserves consistency is the programmers job!

Key Idea: If any action of a transaction T~i~ (e.g., writing record X) impacts T~j~ (e.g., reading record X), one of them will lock X first and the other will have to wait until the first one is done ? which orders the transactions!



### E-R model

elements: entity(triangle), relationship(rhombus), attribute(oval)

**cardinality constraint**: 1 to 1, 1 to many, many to 1, many to many

**participation constraint**: total(double line), partial. participation constraints lead to ```NOT NULL``` as well

additional advanced ER features

- ISA Hierarchies: If we declare A ISA B, every A entity is also considered to be a B entity.
  - Reasons for using ISA:
    - To add descriptive attributes specific to a subclass.
    - To identify subclasses that participate in a relationship.
- Aggregation: allows us to treat a relationship set as an entity set for purposes of participating in (other) relationships.
- multi-valued
- derived (vs. base/stored) attributes
- composite (vs. atomic) attributes



### primary key, foreign key, super key and candidate key

Foreign key : Set of fields in one relation used to “refer” to a tuple in another relation. (Must refer to the primary key of the other relation.) Like a “logical pointer”.

primary key: **primary key is NOT NULL**

candidate key < super key

[superkey, candidate key, prime key](https://blog.csdn.net/suguoliang/article/details/82844328)

If X is part of a (candidate) key, we will say that X is a prime attribute.
If X (an attribute set) contains a candidate key, we will say that X is a superkey.
X -> Y can be pronounced as “X determines Y”, or “Y is functionally dependent on X”.
Some types of dependencies (on a key):
**Trivial**: XY -> X
**Partial**: XY is a key, X -> Z
**Transitive**: X -> Y, Y -> Z, Y is non-prime, X -> Z

[MySQL 表的一对一、一对多、多对多问题](https://www.cnblogs.com/Camiluo/p/10615065.html)



### FD, redundancy and norm form

#### the Evils of Redundancy

Redundancy is at the root of several problems associated with relational schemas:

- Redundant storage
- Insert/delete/update anomalies

#### Functional Dependencies(FDs)

if X->Y, we say X determines Y, in the other word, for t~1~, t~2~ in the table(where X and belongs), t~1~.X=t~2~.X implies t~1~.Y=t~2~.Y

F^+^=closure of F is the set of all FDs that are implied by F

properties

- reflexivity: if X $\in$ Y, then Y->X
- augmentation: if X->Y, then XZ->YZ for any Z
- transitivity: if X->Y and Y->Z, then X->Z
- union: if X->Y and X->Z, then X->YZ
- decomposition: if X->YZ, then X->Y and X->Z

If an attribute X is not on the RHS of any initial FD, X must be part of the key

#### FD and redundancy

Role of FDs in detecting redundancy:

- Consider a relation R with 3 attributes, ABC.
  - If no non-trivial FDs hold: There is no redundancy here then. (Think about this – in fact, think hard...!)
  - Given A -> B: Several tuples could have the same A value – and if so, then they’ll all have the same B value as well! (Thus if A is repeated for some reason, it will always have the same B “tagging along for the ride”.)

#### Norm Forms

Depending upon the normal form a relation is in, it has different level of redundancy

Checking for which normal form a relation is in will help us decide whether to decompose the relation

##### 1NF

Rel’n R is in 1NF if all of its attributes are atomic.(No set-valued attributes! (1NF = “flat”)

##### 2NF

Rel’n R is in 2NF if it is in 1NF and no non-prime attribute is partially dependent on a candidate key of R.

##### 3NF

Rel’n R is in 3NF if it is in 2NF and it has no transitive dependencies to non-prime attributes.

##### 3NF Alternative Definition

Rel’n R with FDs F is in 3NF if, for all X -> A in F+

- A $\in$ X (trivial FD), or else
- X is a superkey (i.e., contains a key) for R, or else
- A is part of some key for R (i.e., it’s a prime attribute).

If R is in BCNF, clearly it is also in 3NF.
If R is in 3NF, some redundancy is possible. 3NF is a compromise to use when BCNF isn’t achievable (e.g., no “good” decomp, or performance considerations).

##### Boyce-Codd Normal Form(BCNF)

Rel’n R with FDs F is in BCNF if, for all X -> A in F+

- A $\in$ X (trivial FD), or else
- X is a superkey (i.e., contains a key) for R

#### Decomposition of a Relation Scheme

The decomposition of R into two tables X and Y is dependency preserving if (F~x~ union F~y~)^+^ = F^+^

Dependency preserving does not imply lossless join

Intuitively, decomposing R means we will store instances of the relations from the decomposition instead of instances of R.

There are three potential problems to consider:

1. Some queries become more expensive.
   - E.g., how much did sailor Joe earn? (W*H now requires a join)
2. Given instances of the decomposed relations, we may not be able to reconstruct the corresponding instance of the original relation! (If “lossy”...)
   - Fortunately, not a problem in the SNLRWH example!

3. Checking some dependencies may require joining the instances of the decomposed relations.
   - Fortunately, also not in the SNLRWH example.

Tradeoff: Consider these issues vs. the redundancy.



### Query language

- A query is applied to relation instances, and the result of a query is also a relation instance.

  - Schemas of input relations for a query are fixed (but query will run regardless of instance!)

  - The schema for the result of a given query is also fixed! Determined by definition of query language constructs.

- Positional vs. named-field notation:

  - Positional notation easier for formal definitions, named-field notation more readable.

  - Both used in SQL (but try to avoid positional stuff!)

[relation algebra](https://blog.csdn.net/zsi386/article/details/79091307): cross product($\times$) usually results in more results than natural joins($\bowtie$). conditional joins(also called theta join) is like a selection of the result of cross product

**projection($\pi_{name,age}(Student)$)**:No duplicates in result!

**selection($\sigma_{age>=40}(Employee)$)**:No duplicates in result!

**renaming($\rho{C(1->sid1, 5->sid2), S1 \times S2}$)**, other renaming option (1 is position,  $S1 \times S2$ is source)

- $\rho{(S1R1(1->sid1), S1 \times R1)}$

- $\rho{(TempS1(sid->sid1), S1)}$

  $TempS1 \times R1$

- $(\pi_{sid->sid1, sname, rating, age}(S1))\times R1$

#### join

Equi-Join: A special case of condition join where the condition c contains only equalities. Result schema similar to cross-product, but only one copy of fields for which equality is specified

Natural Join: An equijoin on all commonly named fields.

#### Union($\cup$), Intersection($\cap$), Set-Difference($-$)

All of these operations take two input relations, which must be union-compatible:

- **Same number of fields.**

- “Corresponding” fields are of the same type.

#### Division

- Not a primitive operator, but extremely useful for expressing queries like:

  - Find sailors who have reserved all boats.

- Let A have 2 fields, x and y, while B has one field y, so we have relations A(x,y) and B(y):

  - A/B contains the x tuples (e.g., sailors) such that for every y tuple (e.g., boat) in B, there is an xy tuple in A.

  - Or: If the set of y values (boats) associated with an x value (sailor) in A contains all y values in B, the x value is in A/B.

- In general, x and y can be any lists of fields; y is the list of fields in B, and x $\cup$ y is the list of fields of A.



### Relational Calculus

- Comes in two flavors: Tuple relational calculus (TRC) and Domain relational calculus (DRC).

- Calculus has variables, constants, comparison ops, logical connectives and quantifiers.

  - TRC: Variables range over (i.e., get bound to) tuples.

  - DRC: Variables range over domain elements (= field values).

  - Both TRC and DRC are simple subsets of first-order logic.

- Expressions in the calculus are called formulas. An answer tuple is essentially an assignment of constants to variables that make the formula evaluate to true.

- TRC is the basis for various query languages (Quel, SQL, OQL, XQuery, …), while DRC is the basis for example based relational query UIs. We’ll study TRC!

#### Tuple Relation Calculus

- Query in TRC has the form: { t(attrlist) $\mid$ P(t) }​
- Answer includes all tuples t with (optionally) specified schema (attrlist) that cause formula P(t) to be true.
- Formula is recursively defined, starting with simple atomic formulas (getting tuples from relations or making comparisons of values), and building up bigger and better Boolean formulas using logical connectives.

##### TRC formulas

- atomic formula:
  - r $\in$ R, or r $\notin$ R, or r.a op s.b or r.a op constant
  - op is one of <, >, $\le, \ge, \neq$, =
- formula
  - an atomic formula, or

##### Free and Bound Variables

- The use of a quantifier such as $\forall$t $\in$ T or $\exists$t $\in$ T in a formula is said to bind t.
  - A variable that is not bound is free.
- Now let us revisit the definition of a TRC query:
  - { t(a1, a2, …) $\mid$ P(t) }
- There is an important restriction: the variable t that appears to the left of the $\mid$ (“such that”) symbol must be the only free  variable in the formula P(...).

##### Unsafe Queries and Expressive Power
- It is possible to write syntactically correct calculus queries that have an infinite number of answers! Such queries are called unsafe.
  - E.g., $s \mid s \notin Sailors$
- It is known that every query that can be expressed in relational algebra can be expressed as a safe query in DRC / TRC; the converse is also true.
- Relational Completeness: Query language (e.g., SQL) can express every query that is expressible in relational algebra/calculus.

### weak entity

A **weak entity** can be identified uniquely only by considering the primary key of some other (owner) entity.

1. Owner entity set and weak entity set must participate in a one-to many relationship set (one owner, many weak entities).
2. Weak entity set must have total participation in this identifying relationship set.
3. ==Dependent identifier is unique only within owner context (--- ), so its fully qualified key here is (```ssn```, ```dname```)==



### view

A **view** is just a relation, but we store its **definition** rather than storing the (materialized) set of tuples.

Other view uses in our ER translation context might include:

- Derived attributes, e.g., age (vs. birthdate)
- Simplifying/eliminating join paths (for SQL)
- Beautifying the “Mashup table” approach (to ISA)

```mysql
CREATE VIEW YoungActiveStudents (name, grade)
AS SELECT S.name, E.grade
FROM Students S, Enrolled E
WHERE S.sid = E.sid and S.age < 21

CREATE VIEW EmployeeView (ssn, name, bdate, age)
AS SELECT E.ssn, E.name, E.bdate,
TIMESTAMPDIFF(YEAR, E.bdate, CURDATE( ))
FROM Employees E
```



### Some code

```mysql
CREATE TABLE Department2(
	mgr_ssn CHAR(11) NOT NULL
	foreign key(mgr_ssm) REFERENCES Employees, ON DELETE NO ACTION)
	
/*unique:this attribute is unique
varchar 
decimal 
auto_increment*/
```

