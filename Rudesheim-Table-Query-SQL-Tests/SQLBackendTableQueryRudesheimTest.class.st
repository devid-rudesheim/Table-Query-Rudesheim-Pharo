"
End-to-end reproduction of the customers/orders equi-join + parameter example from note/table-query-redesign.md, via Rudesheim TableQuery Backend SQL Driver Fake.
"
Class {
	#name : 'SQLBackendTableQueryRudesheimTest',
	#superclass : 'BackendTableQueryRudesheimTest',
	#category : 'Rudesheim-Table-Query-SQL-Tests-Backend',
	#package : 'Rudesheim-Table-Query-SQL-Tests',
	#tag : 'Backend'
}

{ #category : 'accessing' }
SQLBackendTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim
		TableQuery
		Backend
		SQL.
]

{ #category : 'accessing' }
SQLBackendTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		driver:
		(
			Rudesheim TableQuery Backend SQL Driver Fake
				tables:	self sourceTables
		).
]

{ #category : 'accessing' }
SQLBackendTableQueryRudesheimTest >> querySources [
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

{ #category : 'tests' }
SQLBackendTableQueryRudesheimTest >> testAsRHTableQueryAsInSQLUsing [
	|
		query
	|

	query :=
		(
			self querySources
				asRHTableQuery
				asInSQLUsing:
				(
					Rudesheim TableQuery Backend SQL Driver Fake
						tables:	self sourceTables
				)
		)
			prepareTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						rows
							first
							id
							= rows second customerId
							& (rows second total > parameters first).
					]
					collect:
					[
						rows
							first
							name.
					].
			].

	self
		assert:	query sqlString
		equals:	'SELECT t1.name FROM customers t1, orders t2 WHERE ((t1.id = t2.customerId) AND (t2.total > ?))'.

	self
		assertCollection:
		(
			query
				valueWithArguments:	{100}
		)
		hasSameElements:	#('Alice' 'Bob').
]

{ #category : 'tests' }
SQLBackendTableQueryRudesheimTest >> testPreparedQuerySqlString [
	self
		assert:
		self
			preparedQuery
			sqlString
		equals:	'SELECT t1.name FROM customers t1, orders t2 WHERE ((t1.id = t2.customerId) AND (t2.total > ?))'.
]

{ #category : 'tests' }
SQLBackendTableQueryRudesheimTest >> testPreparedQuerySqlStringWithOr [
	|
		query
	|

	query :=
		self basicTarget
			prepareTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						rows
							first
							id
							= parameters first
							| (rows first name = parameters second).
					]
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
		equals:	'SELECT t1.name FROM customers t1 WHERE ((t1.id = ?) OR (t1.name = ?))'.
]

{ #category : 'tests' }
SQLBackendTableQueryRudesheimTest >> testPreparedQuerySqlStringWithProjection [
	|
		query
	|

	query :=
		self basicTarget
			prepareTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						rows
							first
							id
							= parameters first.
					]
					collect:
					[
						{
							rows
								first
								id.
							rows
								first
								name
						}.
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
		equals:	'SELECT t1.id, t1.name FROM customers t1 WHERE (t1.id = ?)'.
]

{ #category : 'tests' }
SQLBackendTableQueryRudesheimTest >> testPreparedQuerySqlStringWithProjectionOneColumn [
	|
		query
	|

	query :=
		self basicTarget
			prepareTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						rows
							first
							id
							= parameters first.
					]
					collect:
					[
						{
							rows
								first
								id
						}.
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
		equals:	'SELECT t1.id FROM customers t1 WHERE (t1.id = ?)'.
]

{ #category : 'tests' }
SQLBackendTableQueryRudesheimTest >> testPreparedQuerySqlStringWithProjectionThreeColumns [
	|
		query
	|

	query :=
		self basicTarget
			prepareTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						rows
							first
							id
							= rows second customerId.
					]
					collect:
					[
						{
							rows
								first
								id.
							rows
								first
								name.
							rows
								second
								total
						}.
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

	self
		assert:	query sqlString
		equals:	'SELECT t1.id, t1.name, t2.total FROM customers t1, orders t2 WHERE (t1.id = t2.customerId)'.
]

{ #category : 'tests' }
SQLBackendTableQueryRudesheimTest >> testPreparedQuerySqlStringWithoutWhere [
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
