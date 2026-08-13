Class {
	#name : 'InMemoryBackendTableQueryRudesheimTest',
	#superclass : 'BackendTableQueryRudesheimTest',
	#category : 'Rudesheim-Table-Query-InMemory-Tests-Backend',
	#package : 'Rudesheim-Table-Query-InMemory-Tests',
	#tag : 'Backend'
}

{ #category : 'accessing' }
InMemoryBackendTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim
		TableQuery
		Backend
		InMemory.
]

{ #category : 'accessing' }
InMemoryBackendTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass.
]

{ #category : 'accessing' }
InMemoryBackendTableQueryRudesheimTest >> querySources [
	^ self sourceTables
		collect:
		[ :eachAssociation |
			eachAssociation value.
		].
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testBasicInstanceCreation0 [
	self
		assert:	self basicTarget
		equals:	self targetClass.
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testInquireTableQueryUsesEqualityIntersectionWithMixedValueAccess [
	|
		result
	|

	result :=
		self basicTarget
			inquireTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						(
							rows first value
								= rows second value
						)
							&
							(
								rows second value
									= rows last
							).
					]
					collect:
					[
						{rows first .  rows last}.
					].
			]
			from:
			(
				{
					(
						1
							to:	1000
					).
					(
						500
							to:	550
					).
					(
						1
							to:	1000
					)
				}
					collect:
					[ :eachCollection |
						eachCollection
							collect:
							[ :eachInteger |
								eachInteger asValueHolder.
							].
					]
			).

	self
		assert:	result size
		equals:	51.

	self
		assert:
		(
			result first
				collect:
				[ :eachValueHolder |
					eachValueHolder value.
				]
		)
		equals:	#(500 500).

	self
		assert:
		(
			result last
				collect:
				[ :eachValueHolder |
					eachValueHolder value.
				]
		)
		equals:	#(550 550).
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testInquireTableQueryUsesEqualityIntersectionWithValueAccess [
	|
		result
	|

	result :=
		self basicTarget
			inquireTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						(
							rows first value
								= rows second value
						)
							&
							(
								rows second value
									= rows last value
							).
					]
					collect:
					[
						{rows first .  rows last}.
					].
			]
			from:
			(
				{
					(
						1
							to:	1000
					).
					(
						500
							to:	550
					).
					(
						1
							to:	1000
					)
				}
					collect:
					[ :eachCollection |
						eachCollection
							collect:
							[ :eachInteger |
								eachInteger asValueHolder.
							].
					]
			).

	self
		assert:	result size
		equals:	51.

	self
		assert:
		(
			result first
				collect:
				[ :eachValueHolder |
					eachValueHolder value.
				]
		)
		equals:	#(500 500).

	self
		assert:
		(
			result last
				collect:
				[ :eachValueHolder |
					eachValueHolder value.
				]
		)
		equals:	#(550 550).
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testInquireTableQueryUsesWholeRowEqualityIntersection [
	|
		result
	|

	result :=
		self basicTarget
			inquireTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						rows
							first
							= rows second
							& (rows second = rows last).
					]
					collect:
					[
						{rows first .  rows last}.
					].
			]
			from:
			{
				(
					1
						to:	1000
				).
				(
					500
						to:	550
				).
				(
					1
						to:	1000
				)
			}.

	self
		assert:	result size
		equals:	51.

	self
		assert:
		result
			first
			asArray
		equals:	#(500 500).

	self
		assert:
		result
			last
			asArray
		equals:	#(550 550).
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testPlanForUsesDMirrorSequentialAboveThreshold [
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
						rows first
							> 0.
					]
					collect:
					[
						rows first.
					].
			]
			from:
			{
				(
					1
						to:	1001
				).
				(
					1
						to:	1000
				)
			}.

	self
		assert:
		(
			preparedQuery
				planFor:	preparedQuery optimizationContext
		) class
		equals:
		Rudesheim
			TableQuery
			Backend
			InMemory
			Plan
			DMirror
			Sequential.
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testPlanForUsesEqualityIntersectionBelowDMirrorThreshold [
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
						rows
							first
							= rows second
							& (rows second = rows last).
					]
					collect:
					[
						{rows first .  rows last}.
					].
			]
			from:
			{
				(
					1
						to:	200
				).
				(
					50
						to:	60
				).
				(
					1
						to:	200
				)
			}.

	self
		assert:
		(
			preparedQuery
				planFor:	preparedQuery optimizationContext
		) class
		equals: Rudesheim TableQuery Backend InMemory Plan EqualityIntersection.
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testPlanForUsesEqualityIntersectionWhenDriverInputIsBelowDMirrorThreshold [
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
						rows
							first
							= rows second
							& (rows second = rows last).
					]
					collect:
					[
						{rows first .  rows last}.
					].
			]
			from:
			{
				(
					1
						to:	1000
				).
				(
					500
						to:	550
				).
				(
					1
						to:	1000
				)
			}.

	self
		assert:
		(
			preparedQuery
				planFor:	preparedQuery optimizationContext
		) class
		equals:
		Rudesheim
			TableQuery
			Backend
			InMemory
			Plan
			EqualityIntersection.
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testPlanForUsesEqualityIntersectionWithParameterEqualityWhenDriverInputIsBelowDMirrorThreshold [
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
						(
							rows first key
								= rows second key
						)
							&
							(
								rows first key
									= rows last key
							)
							&
							(
								rows first key
									= parameters first
							).
					]
					collect:
					[
						{rows first .  rows last}.
					].
			]
			from:
			(
				{
					(
						1
							to:	1000000
					).
					(
						1
							to:	100
					).
					(
						1
							to:	1000000
					)
				}
					collect:
					[ :eachCollection |
						eachCollection
							collect:
							[ :eachInteger |
								eachInteger -> eachInteger.
							].
					]
			).

	self
		assert:
		(
			preparedQuery
				planFor:	preparedQuery optimizationContext
		) class
		equals: Rudesheim TableQuery Backend InMemory Plan EqualityIntersection.
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testPlanForUsesSmallInputSequentialForSmallInput [
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
						rows first
							= rows second.
					]
					collect:
					[
						rows first.
					].
			]
			from:
			{
				(
					1
						to:	5
				).
				(
					3
						to:	4
				)
			}.

	self
		assert:
		(
			preparedQuery
				planFor:	preparedQuery optimizationContext
		) class
		equals:
		Rudesheim
			TableQuery
			Backend
			InMemory
			Plan
			SmallInputSequential.
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testPlanNamespace [
	|
		plan
	|

	plan := Rudesheim TableQuery Backend InMemory Plan.

	self
		assert:	plan Sequential
		equals:	SequentialPlanInMemoryBackendTableQueryRudesheim.

	self
		assert:	plan DMirror Sequential
		equals:	DMirrorSequentialPlanInMemoryBackendTableQueryRudesheim.

	self
		assert:	plan SmallInputSequential
		equals:	SmallInputSequentialPlanInMemoryBackendTableQueryRudesheim.

	self
		assert:	plan EqualityIntersection
		equals:	EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim.

	self
		assert:	plan DMirror EqualityIntersection
		equals:	DMirrorEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim.
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testPreparedQueryUsesParameterEqualityIntersection [
	|
		preparedQuery
		matchingResult
		missingResult
	|

	preparedQuery :=
		self basicTarget
			prepareTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						(
							rows first key
								= rows second key
						)
							&
							(
								rows first key
									= rows last key
							)
							&
							(
								rows first key
									= parameters first
							).
					]
					collect:
					[
						{rows first .  rows last}.
					].
			]
			from:
			(
				{
					(
						1
							to:	200
					).
					(
						50
							to:	60
					).
					(
						1
							to:	200
					)
				}
					collect:
					[ :eachCollection |
						eachCollection
							collect:
							[ :eachInteger |
								eachInteger -> eachInteger.
							].
					]
			).

	self
		assert:
		(
			preparedQuery
				planFor:	preparedQuery optimizationContext
		) class
		equals:
		Rudesheim
			TableQuery
			Backend
			InMemory
			Plan
			EqualityIntersection.

	matchingResult :=
		preparedQuery
			value:	50.

	missingResult :=
		preparedQuery
			value:	0.

	self
		assert:	matchingResult size
		equals:	1.

	self
		assert:	matchingResult first
		equals:	#(50 50).

	self
		assert:	missingResult asArray
		equals:	#().
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testPreparedQueryUsesParameterEqualityIntersectionWithNestedAccessor [
	|
		preparedQuery
		matchingResult
		missingResult
	|

	preparedQuery :=
		self basicTarget
			prepareTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						(
							rows first value key
								= rows second value key
						)
							&
							(
								rows first value key
									= rows last value key
							)
							&
							(
								rows first value key
									= parameters first
							).
					]
					collect:
					[
						{rows first value key .  rows last value key}.
					].
			]
			from:
			(
				{
					(
						1
							to:	200
					).
					(
						50
							to:	60
					).
					(
						1
							to:	200
					)
				}
					collect:
					[ :eachCollection |
						eachCollection
							collect:
							[ :eachInteger |
								eachInteger -> (eachInteger -> eachInteger).
							].
					]
			).

	self
		assert:
		(
			preparedQuery
				planFor:	preparedQuery optimizationContext
		) class
		equals: Rudesheim TableQuery Backend InMemory Plan EqualityIntersection.

	matchingResult :=
		preparedQuery
			value:	50.

	missingResult :=
		preparedQuery
			value:	0.

	self
		assert:	matchingResult size
		equals:	1.

	self
		assert:	matchingResult first
		equals:	#(50 50).

	self
		assert:	missingResult asArray
		equals:	#().
]

{ #category : 'tests' }
InMemoryBackendTableQueryRudesheimTest >> testPreparedQueryWithParameterEqualityDefersCandidateGeneration [
	|
		preparedQuery
		plan
		result
	|

	preparedQuery :=
		self basicTarget
			prepareTableQuery:
			[ :statement :rows :parameters |
				statement
					select:
					[
						(
							rows first key
								= rows second key
						)
							&
							(
								rows first key
									= rows last key
							)
							&
							(
								rows first key
									= parameters first
							).
					]
					collect:
					[
						{rows first .  rows last}.
					].
			]
			from:
			(
				{
					(
						1
							to:	200
					).
					(
						1
							to:	200
					).
					(
						1
							to:	200
					)
				}
					collect:
					[ :eachCollection |
						eachCollection
							collect:
							[ :eachInteger |
								eachInteger -> eachInteger.
							].
					]
			).

	plan :=
		preparedQuery
			planFor:	preparedQuery optimizationContext.

	self
		assert:
		(
			plan
				instVarNamed:	'candidateValues'
		)
		equals:	nil.

	result :=
		plan
			executeWithArguments:	#(1).

	self
		assert:	result asArray
		equals:
		{
			#(1 1).
		}.
]
