## About
The project shows how to implements multi tenancy in MySQL and PostgreSQL databases.

## Multi tenancy
The term "multi tenancy" refers to a software architecture in which a single instance of software runs on a server and serves multiple tenants.

## Data partitioning
In the multi tenancy architecture we need think how the data will be provided for multiple tenants. Basically we have three strategies for data partitioning in multi tenancy architecture.

- Individual database
- Database shared
- Schema shared

**INDIVIDUAL DATABASE**

In this strategy each tenant will have a specific database.

Pros

- Native data isolation
- Good performance
- Long operations does not impact other tenants
- Easy backup
- Easy data extraction

Cons

- Complex logic for connect to different databases
- Updates need to be applied for all databases


**DATABASE SHARED**

In this strategy the application has only one database that will be shared with all tenants.

Pros

- Easy updates
- Easy maintenance

Cons

- Tables with extra column to identify tenant
- SQL queries with extra item in clause where
- Operations can impact other tenants
- Database size
- Slow backup because database size
- Data extraction need consider multi tenants


**SCHEMA SHARED**

In this strategy the database will have a schema for each tenant.

Pros

- Logical data isolation

Cons

- Some RDBMS doesn't have support to multiple schema
- For each new tenant will be necessary create a new schema in database
- Complex logic for connect to different schema

## Row-Level Security
Row-Level Security is a security mechanism that restricts the records from a database table based on the authorization context of the current user that is logged in. This means the records from the tables are displayed based on who the user is and to which records do the user has access to. 

The following RDBMS does not have support to RLS:

- MySQL
- MariaDB
- Firebird

For implement RLS in these RDBMS is necessary to use extra column in tables, create triggers to insert or update records with right user, create views to select data specific.

The RLS is supported natively in PostgreSQL, MSSQL Server and Oracle Database.

## References
[Wikipedia](https://en.wikipedia.org/wiki/Multitenancy)  
[PostgreSQL Row-Level Security](https://www.postgresql.org/docs/13/ddl-rowsecurity.html)  
[PostgreSQL Schemas](https://www.postgresql.org/docs/13/ddl-schemas.html)
