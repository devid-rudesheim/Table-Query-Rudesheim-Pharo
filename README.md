# Rudesheim Table Query for Pharo

Rudesheim Table Query is a query layer for Pharo collections and relational backends.
It lets a query be written once as a Smalltalk expression tree and prepared against an in-memory backend or an SQL backend.

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
query :=
	{
		(1 to: 5).
		(1 to: 10)
	}
		asRHTableQuery
		asInMemory.

query
	inquireTableQuery:
	[ :statement :rows |
		statement
			select: [ rows first asNumber = rows second asNumber ];
			collect: [ rows first copy ].
	]
```

The result is the values that satisfy the expression over the selected backend.

## Run Tests

After loading the test groups, run:

```smalltalk
TestSuite new
	addTest: (RPackageOrganizer default packageNamed: 'Rudesheim-Table-Query-Tests') asTestSuite;
	addTest: (RPackageOrganizer default packageNamed: 'Rudesheim-Table-Query-InMemory-Tests') asTestSuite;
	addTest: (RPackageOrganizer default packageNamed: 'Rudesheim-Table-Query-SQL-Tests') asTestSuite;
	run
```
