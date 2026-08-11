"
Shared execution-result tests for table query backends. SQL-specific string rendering stays in SQLBackendTableQueryRudesheimTest; subclasses only provide the backend and the `from:` input shape.
"
Class {
	#name : 'BackendTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#instVars : [
		'preparedQuery'
	],
	#category : 'Rudesheim-Table-Query-Tests-Backend',
	#package : 'Rudesheim-Table-Query-Tests',
	#tag : 'Backend'
}

{ #category : 'testing' }
BackendTableQueryRudesheimTest class >> isAbstract [
	^ self == BackendTableQueryRudesheimTest.
]

{ #category : 'accessing' }
BackendTableQueryRudesheimTest >> preparedQuery [
	^ preparedQuery
		ifNil:
		[
			preparedQuery :=
				self basicTarget
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
					]
					from:	self querySources.
		].
]

{ #category : 'accessing' }
BackendTableQueryRudesheimTest >> querySources [
	^ self subclassResponsibility.
]

{ #category : 'running' }
BackendTableQueryRudesheimTest >> setUp [
	super setUp.
	preparedQuery := nil.
]

{ #category : 'accessing' }
BackendTableQueryRudesheimTest >> sourceTables [
	^ {(#customers -> (OrderedCollection new          add: (CustomerFixtureForTestTableQueryRudesheim id: 1 name: 'Alice');          add: (CustomerFixtureForTestTableQueryRudesheim id: 2 name: 'Bob');          yourself)) .  (#orders -> (OrderedCollection new          add: (OrderFixtureForTestTableQueryRudesheim customerId: 1 total: 150);          add: (OrderFixtureForTestTableQueryRudesheim customerId: 1 total: 50);          add: (OrderFixtureForTestTableQueryRudesheim customerId: 2 total: 300);          yourself))}.
]

{ #category : 'tests' }
BackendTableQueryRudesheimTest >> testPrepareTableQueryCullsUnusedParameters [
	|
		query
	|

	query :=
		self basicTarget
			prepareTableQuery:
			[ :statement :rows |
				statement
					collect:
					[
						rows
							first
							name.
					].
			]
			from:
			(
				self querySources
					copyFrom:	1
					to:	1
			).

	self
		assert:
		(
			query
				valueWithArguments:	#()
		)
			asArray
		equals:	#('Alice' 'Bob').
]

{ #category : 'tests' }
BackendTableQueryRudesheimTest >> testValueWithArgumentsAboveThreshold [
	self
		assertCollection:
		(
			self preparedQuery
				valueWithArguments:	{100}
		)
		hasSameElements:	#('Alice' 'Bob').
]

{ #category : 'tests' }
BackendTableQueryRudesheimTest >> testValueWithArgumentsNoneAboveThreshold [
	self
		assert:
		(
			self preparedQuery
				valueWithArguments:	{500}
		)
			isEmpty.
]

{ #category : 'tests' }
BackendTableQueryRudesheimTest >> testValueWithArgumentsWithProjection [
	|
		query
		result
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
							= rows second customerId
							& (rows second total > parameters first).
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
			from:	self querySources.

	result :=
		query
			valueWithArguments:	{100}.

	self
		assert:	result size
		equals:	2.

	self
		assert:
		result
			first
			asArray
		equals:	#(1 'Alice').

	self
		assert:
		result
			second
			asArray
		equals:	#(2 'Bob').
]

{ #category : 'tests' }
BackendTableQueryRudesheimTest >> testValueWithArgumentsWithProjectionOneColumn [
	|
		query
		result
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
			(
				self querySources
					copyFrom:	1
					to:	1
			).

	result :=
		query
			valueWithArguments:	{1}.

	self
		assert:	result size
		equals:	1.

	self
		assert:
		result
			first
			asArray
		equals:	#(1).
]

{ #category : 'tests' }
BackendTableQueryRudesheimTest >> testValueWithArgumentsWithProjectionThreeColumns [
	|
		query
		result
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
							= rows second customerId
							& (rows second total > parameters first).
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
			from:	self querySources.

	result :=
		query
			valueWithArguments:	{100}.

	self
		assert:	result size
		equals:	2.

	self
		assert:
		result
			first
			asArray
		equals:	#(1 'Alice' 150).

	self
		assert:
		result
			second
			asArray
		equals:	#(2 'Bob' 300).
]

{ #category : 'tests' }
BackendTableQueryRudesheimTest >> testValueWithArgumentsWithoutWhere [
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
			(
				self querySources
					copyFrom:	1
					to:	1
			).

	self
		assert:
		(
			query
				valueWithArguments:	#()
		)
			asArray
		equals:	#('Alice' 'Bob').
]
