Class {
	#name : 'SQLite3DriverSQLBackendTableQueryRudesheimTest',
	#superclass : 'BackendTableQueryRudesheimTest',
	#instVars : [
		'connection'
	],
	#category : 'Rudesheim-Table-Query-SQL-SQLite3-Tests-Driver',
	#package : 'Rudesheim-Table-Query-SQL-SQLite3-Tests',
	#tag : 'Driver'
}

{ #category : 'accessing' }
SQLite3DriverSQLBackendTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim TableQuery Backend SQL.
]

{ #category : 'private' }
SQLite3DriverSQLBackendTableQueryRudesheimTest >> createConnection [
	|
		sqlite3ConnectionClass
	|

	sqlite3ConnectionClass :=
		Smalltalk globals
			at:	#SQLite3Connection
			ifAbsent:
			[
				self
					error:	'SQLite3Connection is not installed'.
			].

	^ sqlite3ConnectionClass memory
		open;
		yourself.
]

{ #category : 'accessing' }
SQLite3DriverSQLBackendTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		driver:
		(
			self driverClass
				connection:	connection
		).
]

{ #category : 'accessing' }
SQLite3DriverSQLBackendTableQueryRudesheimTest >> driverClass [
	^ Rudesheim TableQuery Backend SQL Driver SQLite3.
]

{ #category : 'private' }
SQLite3DriverSQLBackendTableQueryRudesheimTest >> insertFixtureRows [
	connection
		execute:	'CREATE TABLE customers (id INTEGER PRIMARY KEY, name TEXT);'.
	connection
		execute:	'CREATE TABLE orders (customerId INTEGER, total INTEGER);'.
	connection
		execute:	'INSERT INTO customers (id, name) VALUES (?, ?);'
		value:	1
		value:	'Alice'.
	connection
		execute:	'INSERT INTO customers (id, name) VALUES (?, ?);'
		value:	2
		value:	'Bob'.
	connection
		execute:	'INSERT INTO orders (customerId, total) VALUES (?, ?);'
		value:	1
		value:	150.
	connection
		execute:	'INSERT INTO orders (customerId, total) VALUES (?, ?);'
		value:	1
		value:	50.
	connection
		execute:	'INSERT INTO orders (customerId, total) VALUES (?, ?);'
		value:	2
		value:	300.
]

{ #category : 'accessing' }
SQLite3DriverSQLBackendTableQueryRudesheimTest >> querySources [
	^
	{
		(
			Rudesheim
				TableQuery
				Backend
				SQL
				Table
				name:	#customers
		).
		(
			Rudesheim
				TableQuery
				Backend
				SQL
				Table
				name:	#orders
		)
	}.
]

{ #category : 'running' }
SQLite3DriverSQLBackendTableQueryRudesheimTest >> setUp [
	super setUp.
	connection := self createConnection.
	self insertFixtureRows.
]

{ #category : 'running' }
SQLite3DriverSQLBackendTableQueryRudesheimTest >> tearDown [
	connection
		ifNotNil:
		[
			connection close.
			connection := nil.
		].
	super tearDown.
]

{ #category : 'tests' }
SQLite3DriverSQLBackendTableQueryRudesheimTest >> testPreparedQuerySqlString [
	self
		assert:
		self
			preparedQuery
			sqlString
		equals:	'SELECT t1.name FROM customers t1, orders t2 WHERE ((t1.id = t2.customerId) AND (t2.total > ?))'.
]

{ #category : 'tests' }
SQLite3DriverSQLBackendTableQueryRudesheimTest >> testPreparedQuerySqlStringWithoutWhere [
	|
		query
	|

	query :=
		self basicTarget
			prepareTableQuery:
			[ :statement :rows :parameters |
				statement
					collect:
					[
						rows
							first
							name.
					].
			]
			from:
			{
				(
					Rudesheim
						TableQuery
						Backend
						SQL
						Table
						name:	#customers
				)
			}.

	self
		assert:	query sqlString
		equals:	'SELECT t1.name FROM customers t1'.
]
