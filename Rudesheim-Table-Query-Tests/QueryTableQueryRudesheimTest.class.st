"
A RHTQQueryTest is a test class for testing the behavior of RHTQQuery
"
Class {
	#name : 'QueryTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#instVars : [
		'expectValues',
		'sourceCollections'
	],
	#category : 'Rudesheim-Table-Query-Tests-Query',
	#package : 'Rudesheim-Table-Query-Tests',
	#tag : 'Query'
}

{ #category : 'accessing' }
QueryTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim
		TableQuery
		Query.
]

{ #category : 'accessing' }
QueryTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		fromCollections:	self sourceCollections
		backend:	Rudesheim TableQuery Backend InMemory.
]

{ #category : 'accessing' }
QueryTableQueryRudesheimTest >> defaultExpectValues [
	^ 1
		to:	5.
]

{ #category : 'accessing' }
QueryTableQueryRudesheimTest >> defaultSourceCollections [
	^
	{
		(
			1
				to:	5
		).
		(
			1
				to:	10
		)
	}.
]

{ #category : 'accessing' }
QueryTableQueryRudesheimTest >> expectValues [
	^ expectValues
		ifNil:
		[
			expectValues := self defaultExpectValues.
		].
]

{ #category : 'accessing' }
QueryTableQueryRudesheimTest >> expectValues: anObject [
	expectValues := anObject.
]

{ #category : 'test' }
QueryTableQueryRudesheimTest >> runInquire0 [
	self
		assert:
		(
			self basicTarget
				inquireTableQuery:
				[ :statement :rows :parameters |
					statement
						select:
						[
							rows
								first
								asNumber
								= rows second asNumber.
						]
						collect:
						[
							rows
								first
								copy.
						].
				]
		)
			asArray
		equals:	self expectValues.
]

{ #category : 'accessing' }
QueryTableQueryRudesheimTest >> sourceCollections [
	^ sourceCollections
		ifNil:
		[
			sourceCollections := self defaultSourceCollections.
		].
]

{ #category : 'accessing' }
QueryTableQueryRudesheimTest >> sourceCollections: anObject [
	sourceCollections := anObject.
]

{ #category : 'test' }
QueryTableQueryRudesheimTest >> testAsRHTableQuery [
	|
		preparedQuery
	|

	preparedQuery :=
		self sourceCollections
			asRHTableQuery
			asInMemory
			prepareTableQuery:
			[ :statement :rows |
				statement
					select:
					[
						rows
							first
							asNumber
							= rows second asNumber.
					]
					collect:
					[
						rows
							first
							copy.
					].
			].

	self
		assert:
		(
			preparedQuery
				valueWithArguments:	#()
		)
			asArray
		equals:	self expectValues.
]

{ #category : 'test' }
QueryTableQueryRudesheimTest >> testBackendMustBeProvidedAtCreation [
	self
		deny:
		(
			self targetClass class
				includesSelector:	#fromCollections:
		).

	#(#asInMemory #asInSQLUsing: #backend:)
		do:
		[ :eachSelector |
			self
				deny:
				(
					self targetClass
						includesSelector:	eachSelector
				).
		].
]

{ #category : 'test' }
QueryTableQueryRudesheimTest >> testInquire [
	self
		testInquire0_0;
		tearDown;
		setUp;
		testInquire0_1.
]

{ #category : 'test' }
QueryTableQueryRudesheimTest >> testInquire0_0 [
	self runInquire0.
]

{ #category : 'test' }
QueryTableQueryRudesheimTest >> testInquire0_1 [
	|
		array
	|

	array :=
		3
			to:	5.

	self
		expectValues:	array;
		sourceCollections:
		{
			array.
			(
				1
					to:	10
			)
		};
		runInquire0.
]

{ #category : 'test' }
QueryTableQueryRudesheimTest >> testPrepareTableQuery [
	|
		preparedQuery
	|

	preparedQuery :=
		self basicTarget
			prepareTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						rows first asNumber = rows second asNumber.
					]
					collect:
					[
						rows first copy.
					].
			].

	self
		assert:
		(
			preparedQuery
				valueWithArguments:	#()
		) asArray
		equals:	self expectValues.
]
