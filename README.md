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

This also loads the required `RudesheimKernel`, `RudesheimUtility`, and `DMirror` dependencies from GitHub.

## Requirements

- Pharo with Metacello.
- Plain in-memory use needs only the default group. The default group loads DMirror for the in-memory optimizer. DMirror uses OSSubprocess, so the supported environment is a POSIX-like operating system.
- SQLite3 use needs the `sqlite3` group. The group loads the `Core` part of Pharo-SQLite3 through the baseline.

## Dependencies

The baseline loads these repositories:

- `RudesheimKernel`: `github://devid-rudesheim/Kernel-Rudesheim-Pharo:main`
- `RudesheimUtility`: `github://devid-rudesheim/Utility-Rudesheim-Pharo:main`
- `DMirror`: `github://ObjectProfile/DMirror/src`

The `sqlite3` group also loads `SQLite3Core` from Pharo-SQLite3:

- `SQLite3`: `github://pharo-rdbms/Pharo-SQLite3/src`, loaded with `#( 'Core' )`

DMirror declares its own OSSubprocess dependency in its baseline. Because the in-memory optimizer uses DMirror, run it on a POSIX-like operating system.

## Load Options

Default runtime load:

```smalltalk
Metacello new
	baseline: 'RudesheimTableQuery';
	repository: 'github://devid-rudesheim/Table-Query-Rudesheim-Pharo:main';
	load
```

SQLite3 adapter:

```smalltalk
Metacello new
	baseline: 'RudesheimTableQuery';
	repository: 'github://devid-rudesheim/Table-Query-Rudesheim-Pharo:main';
	load: #(sqlite3)
```

Core tests:

```smalltalk
Metacello new
	baseline: 'RudesheimTableQuery';
	repository: 'github://devid-rudesheim/Table-Query-Rudesheim-Pharo:main';
	load: #(tests)
```

SQLite3 tests:

```smalltalk
Metacello new
	baseline: 'RudesheimTableQuery';
	repository: 'github://devid-rudesheim/Table-Query-Rudesheim-Pharo:main';
	load: #(sqlite3 sqlite3Tests)
```

## Groups

- `core`: table query, in-memory backend, and SQL backend packages.
- `sqlite3`: SQLite3 SQL backend adapter.
- `tests`: SUnit tests for the core backends.
- `sqlite3Tests`: SUnit tests for the SQLite3 adapter.
- `default`: aliases `core`.

## Basic Use

```smalltalk
sourceCollections :=
{
	1 to: 200.
	50 to: 60.
	1 to: 200
}
	collect:
	[ :eachRange |
		eachRange collect: [ :eachInteger | eachInteger -> eachInteger ].
	].

preparedQuery :=
	sourceCollections asRHTableQuery asInMemory
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

When a prepared query does not need runtime parameters, omit the third block argument:

```smalltalk
preparedQuery :=
{
	1 to: 1000.
	500 to: 550.
	1 to: 1000
} asRHTableQuery asInMemory
	prepareTableQuery:
	[ :statement :rows |
		statement
			select:
			[
				(rows first = rows second)
					& (rows second = rows last).
			]
			collect:
			[
				{ rows first. rows last }.
			].
	].

preparedQuery valueWithArguments: #().
```

Use `inquireTableQuery:` when the query has no runtime parameters and should be evaluated immediately:

```smalltalk
matchedRows :=
{
	1 to: 1000.
	500 to: 550.
	1 to: 1000
} asRHTableQuery asInMemory
	inquireTableQuery:
	[ :statement :rows |
		statement
			select:
			[
				(rows first = rows second)
					& (rows second = rows last).
			]
			collect:
			[
				{ rows first. rows last }.
			].
	].

matchedRows size.
matchedRows first asArray.
```

The result size is `51`, and the first row is `#( 500 500 )`.

The same expression-capturing interface can target SQL:

```smalltalk
backend := Rudesheim TableQuery Backend SQL.
driver := backend FakeRelationalDatabaseDriver tables: sourceTables.
table := backend Table.

query :=
{
	table name: #customers.
	table name: #orders
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

## Usage Constraints

- Query capture blocks accept `:statement :rows :parameters`. If the query does not use runtime parameters, omit the third argument and write `:statement :rows`.
- `inquireTableQuery:` is a one-shot convenience API. It calls `prepareTableQuery:` internally and immediately evaluates the prepared query with no runtime arguments.
- `prepareTableQuery:` captures the expression tree before execution. For a single execution it is not inherently faster than `inquireTableQuery:`, but repeated executions can reuse the captured query and avoid rebuilding the expression tree each time.
- A prepared query is tied to the source collections or tables supplied when it is prepared. In-memory optimized plans can derive candidate or index-like data from those sources during execution. If the source tables are replaced, or if changed contents must be reflected in a fresh optimization basis, run `prepareTableQuery:` again.
- `statement select:collect:` records one predicate expression and one projection expression. Calling it more than once in the same capture block overwrites the previously captured expressions.
- `statement collect:` is the no-filter form. It records a constant true predicate and one projection expression.
- The blocks are evaluated once against symbolic row and parameter objects. They should build expressions from `rows` and `parameters`; arbitrary side effects are not part of the query model.
- SQL output is limited to expressions the SQL renderer can translate. Unsupported Smalltalk messages are not automatically executable by a real SQL backend.
- In-memory execution always works through a plan. If no optimizer accepts the captured expression, it falls back to sequential iteration.
- The `EqualityIntersection` optimizer applies to connected equality predicates over all source collections, optionally including equality with a runtime parameter. The equality predicates must be expressed with `=` and connected with `&`.
- Equality keys can be whole rows or supported accessor chains such as `rows first key` or nested value access. Conditions outside this equality shape do not use the intersection plan.
- Result ordering follows the selected plan and source collections; do not rely on SQL-style ordering unless an explicit backend adds ordering support.

## Run Tests

After loading the test groups, run:

```smalltalk
TestSuite new
	addTest: (RPackageOrganizer default packageNamed: 'Rudesheim-Table-Query-Tests') asTestSuite;
	addTest: (RPackageOrganizer default packageNamed: 'Rudesheim-Table-Query-InMemory-Tests') asTestSuite;
	addTest: (RPackageOrganizer default packageNamed: 'Rudesheim-Table-Query-SQL-Tests') asTestSuite;
	run
```
