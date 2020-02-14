Ensuring that any one transaction (when run all by itself) preserves consistency is the programmers job!

Key Idea: If any action of a transaction T~i~ (e.g., writing record X) impacts T~j~ (e.g., reading record X), one of them will lock X first and the other will have to wait until the first one is done ? which orders the transactions!



elements: entity(triangle), relationship(rhombus), attribute(oval)

**cardinality constraint**: 1 to 1, 1 to many, many to 1, many to many

**participation constraint**: total(double line), partial 

additional advanced ER features

- ISA Hierarchies: If we declare A ISA B, every A entity is also considered to be a B entity.
  - Reasons for using ISA:
    - To add descriptive attributes specific to a subclass.
    - To identify subclasses that participate in a relationship.
- Aggregation: allows us to treat a relationship set as an entity set for purposes of participating in (other) relationships.
- multi-valued
- derived (vs. base/stored) attributes
- composite (vs. atomic) attributes

***

Foreign key : Set of fields in one relation used to “refer” to a tuple in another relation. (Must refer to the primary key of the other relation.) Like a “logical pointer”.

primary key:

super key:



A **weak entity** can be identified uniquely only by considering the primary key of some other (owner) entity.

1. Owner entity set and weak entity set must participate in a one-to many relationship set (one owner, many weak entities).
2. Weak entity set must have total participation in this identifying relationship set.
3. Dependent identifier is unique only within owner context (--- ), so its fully qualified key here is (ssn, dname)



Some code

```mysql
CREATE TABLE Department2(
	mgr_ssn CHAR(11) NOT NULL
	foreign key(mgr_ssm) REFERENCES Employees, ON DELETE NO ACTION)
	
	
```

