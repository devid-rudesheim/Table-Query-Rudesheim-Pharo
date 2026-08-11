# Rudesheim Table Query for Pharo

Rudesheim Table Query is a query layer for Pharo collections and relational backends.
It lets a query be written once as a Smalltalk expression tree and prepared against an in-memory backend or an SQL backend.
The in-memory backend has an optimizer: for supported equality conditions it uses an `EqualityIntersection` plan, avoiding a fully multiplied nested iteration over all source collections.

## Installation

Load the default project group with Metacello:

```smalltalk
Metacello new
	baseline: 'RudesheimTableQuery';
	repository: 'github://devid-rudesheim/Table-Query-Rudesheim-Pharo:main';
	load
```

This also loads the required `RudesheimKernel` and `RudesheimUtility` dependencies from GitHub.

## Optional SQLite3 Support

The default group does not load the SQLite3 adapter. To load it:

```smalltalk
Metacello new
	baseline: 'RudesheimTableQuery';
	repository: 'github://devid-rudesheim/Table-Query-Rudesheim-Pharo:main';
	load: #(sqlite3)
```

## Groups

- `core`: table query, in-memory backend, and SQL backend packages.
- `sqlite3`: SQLite3 SQL backend adapter.
- `tests`: SUnit tests for the core backends.
- `sqlite3Tests`: SUnit tests for the SQLite3 adapter.
- `default`: aliases `core`.

## Basic Use

```smalltalk
preparedQuery :=
	{
		((1 to: 200) collect: [ :eachInteger | eachInteger -> eachInteger ]).
		((50 to: 60) collect: [ :eachInteger | eachInteger -> eachInteger ]).
		((1 to: 200) collect: [ :eachInteger | eachInteger -> eachInteger ])
	} asRHTableQuery asInMemory
		prepareTableQuery:
		[ :statement :rows :parameters |
			statement
				select:
				[
					(rows first key = rows second key)
						& (rows first key = rows last key)
						& (rows first key = parameters first).
				]
				collect:
				[
					{ rows first value. rows last value }.
				].
		].

preparedQuery planFor: preparedQuery optimizationContext.
preparedQuery value: 50.
```

The selected plan is `Rudesheim TableQuery Backend InMemory Plan EqualityIntersection`.
The result is `#( #( 50 50 ) )`.
For this equality shape, the in-memory backend intersects candidate values instead of evaluating every combination from the three input collections.

The same expression-capturing interface can target SQL:

```smalltalk
driver := Rudesheim TableQuery Backend SQL FakeRelationalDatabaseDriver tables: sourceTables.

query :=
	{
		(Rudesheim TableQuery Backend SQL Table name: #customers).
		(Rudesheim TableQuery Backend SQL Table name: #orders)
	} asRHTableQuery
		asInSQLUsing: driver.

preparedQuery :=
	query
		prepareTableQuery:
		[ :statement :rows :parameters |
			statement
				select:
				[
					(rows first id = rows second customerId)
						& (rows second total > parameters first).
				]
				collect:
				[
					rows first name.
				].
		].

preparedQuery sqlString.
preparedQuery value: 100.
```

`sqlString` returns:

```text
SELECT t1.name FROM customers t1, orders t2 WHERE ((t1.id = t2.customerId) AND (t2.total > ?))
```

## Run Tests

After loading the test groups, run:

```smalltalk
TestSuite new
	addTest: (RPackageOrganizer default packageNamed: 'Rudesheim-Table-Query-Tests') asTestSuite;
	addTest: (RPackageOrganizer default packageNamed: 'Rudesheim-Table-Query-InMemory-Tests') asTestSuite;
	addTest: (RPackageOrganizer default packageNamed: 'Rudesheim-Table-Query-SQL-Tests') asTestSuite;
	run
```
