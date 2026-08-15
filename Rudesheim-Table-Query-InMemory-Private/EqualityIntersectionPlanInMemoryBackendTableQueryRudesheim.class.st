Class {
	#name : 'EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewUtilityRudesheim',
	#classTraits : 'TShouldntNewUtilityRudesheim classTrait',
	#instVars : [
		'sourceCollections',
		'whereExpression',
		'selectExpression',
		'tableIndexes',
		'tableKeyAccessorsByTable',
		'rowIndexesByTable',
		'candidateValues',
		'parameterEqualities'
	],
	#category : 'Rudesheim-Table-Query-InMemory-Private-Optimization',
	#package : 'Rudesheim-Table-Query-InMemory-Private',
	#tag : 'Optimization'
}

{ #category : 'testing' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim class >> canOptimize: anOptimizationContextInMemoryBackendTableQueryRudesheim [
	^
	[
		|
			keyAccessorsByTable
			plan
		|

		plan :=
			self
				sources:	anOptimizationContextInMemoryBackendTableQueryRudesheim sourceCollections
				where:	anOptimizationContextInMemoryBackendTableQueryRudesheim whereExpression
				select:	anOptimizationContextInMemoryBackendTableQueryRudesheim selectExpression.

		keyAccessorsByTable :=
			plan
				tableKeyAccessorsFrom:	anOptimizationContextInMemoryBackendTableQueryRudesheim whereExpression.

		keyAccessorsByTable size = anOptimizationContextInMemoryBackendTableQueryRudesheim sourceCollections size.
	]
		on:	Error
		do:
		[ :anError |
			false.
		].
]

{ #category : 'instance creation' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim class >> for: anOptimizationContextInMemoryBackendTableQueryRudesheim [
	^
	(
		self
			sources:	anOptimizationContextInMemoryBackendTableQueryRudesheim sourceCollections
			where:	anOptimizationContextInMemoryBackendTableQueryRudesheim whereExpression
			select:	anOptimizationContextInMemoryBackendTableQueryRudesheim selectExpression
	)
		prepare.
]

{ #category : 'instance creation' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim class >> sources: aSourceCollection
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	^ super new
		setSources:	aSourceCollection
		where:	aWhereExpressionTableQueryRudesheim
		select:	aSelectExpressionTableQueryRudesheim.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> addEqualityFrom: aBinaryExpressionTableQueryRudesheim
to: anOrderedCollection [
	#= = aBinaryExpressionTableQueryRudesheim selector
		ifFalse:
		[
			self
				error:	'unsupported predicate'.
		].

	(
		aBinaryExpressionTableQueryRudesheim receiver equalityKeyOperandRudesheim
	)
		fileEqualityWith:
		(
			aBinaryExpressionTableQueryRudesheim argument equalityKeyOperandRudesheim
		)
		wholeRow:	anOrderedCollection
		parameters:	parameterEqualities.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> candidateRows: aCandidateRowCollection
matchParameters: aParameterCollection [
	parameterEqualities
		do:
		[ :eachEquality |
			|
				tableOperand
				parameterOperand
				tablePosition
			row
			key
		|

			tableOperand := eachEquality first.
			parameterOperand := eachEquality second.
			tablePosition :=
				tableIndexes
					indexOf:	tableOperand tableIndex.
			row :=
				aCandidateRowCollection
					at:	tablePosition.
			key :=
				self
					keyFor:	row
					accessor:	tableOperand keyAccessorPath.

			key
				=
				(
					aParameterCollection
						at:	parameterOperand index
				)
				ifFalse:
				[
					^ false.
				].
		].

	^ true.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> candidateRowsFor: aTableIndexCollection
using: aTableKeySelectorDictionary [
	|
		driverTableIndex
		driverAccessor
		candidateRows
		seenKeys
	|

	driverTableIndex :=
		aTableIndexCollection
			detectMin:
			[ :eachTableIndex |
				(
					sourceCollections
						at:	eachTableIndex
				) size.
			].

	driverAccessor :=
		aTableKeySelectorDictionary
			at:	driverTableIndex.

	candidateRows := OrderedCollection new.
	seenKeys := Set new.

	(
		sourceCollections
			at:	driverTableIndex
	)
		do:
		[ :eachDriverRow |
			|
				driverKey
				matchedRows
			|

			driverKey :=
				self
					keyFor:	eachDriverRow
					accessor:	driverAccessor.

			(
				seenKeys
					includes:	driverKey
			)
				ifFalse:
				[
					seenKeys
						add:	driverKey.

					matchedRows :=
						aTableIndexCollection
							collect:
							[ :eachTableIndex |
								self
									rowMatchingKey:	driverKey
									inTable:	eachTableIndex
									using:	aTableKeySelectorDictionary.
							].

					(
						matchedRows
							allSatisfy:	#notNil
					)
						ifTrue:
						[
							candidateRows
								add:	matchedRows.
						].
				].
		].

	^ candidateRows.
]

{ #category : 'executing' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> executeCandidateValues: aCandidateCollection
withArguments: aCollection [
	|
		results
		rowBindings
		rowProxies
	|

	results := OrderedCollection new.

	rowProxies :=
		(
			1
				to:	sourceCollections size
		)
			collect:
			[ :eachIndex |
				NewValueHolder new.
			].

	rowBindings :=
		rowProxies
			collect:
			[ :eachRowProxy |
				Rudesheim Utility Delegator ForAccessing
					targetFrom:	#value
					of:	eachRowProxy.
			].

	aCandidateCollection
		do:
		[ :eachCandidateRows |
			|
				evaluator
			|

			(
				self
					candidateRows:	eachCandidateRows
					matchParameters:	aCollection
			)
				ifTrue:
				[
					tableIndexes
						with:	eachCandidateRows
						do:
						[ :eachTableIndex :eachRow |
							(
								rowProxies
									at:	eachTableIndex
							)
								value:	eachRow.
						].

					evaluator :=
						Rudesheim TableQuery EvaluatorForExpression
							rows:	rowBindings
							parameters:	aCollection.

					results
						add:
						(
							evaluator
								visit:	selectExpression
						).
				].
		].

	^ results.
]

{ #category : 'executing' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> executeParameterCandidateValuesWithArguments: aCollection [
	|
		candidateRows
	|

	candidateRows :=
		self
			parameterCandidateRowsWithArguments:	aCollection.

	candidateRows
		ifNil:
		[
			^ OrderedCollection new.
		].

	^ self
		executeCandidateValues:
		(
			OrderedCollection
				with:	candidateRows
		)
		withArguments:	aCollection.
]

{ #category : 'executing' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> executeWithArguments: aCollection [
	parameterEqualities
		ifNotEmpty:
		[
			^ self
				executeParameterCandidateValuesWithArguments:	aCollection.
		].

	^ self
		executeCandidateValues:	candidateValues
		withArguments:	aCollection.
]

{ #category : 'testing' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> hasParameterEqualities [
	^ parameterEqualities notEmpty.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> keyFor: anObject
accessor: aCollection [
	|
		key
	|

	key := anObject.

	aCollection
		do:
		[ :eachSelector |
			key :=
				key
					perform:	eachSelector.
		].

	^ key.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> keyFromParameterEqualitiesWithArguments: aCollection [
	|
		key
	|

	key :=
		aCollection
			at:	parameterEqualities first second index.

	parameterEqualities
		do:
		[ :eachEquality |
			key
				=
				(
					aCollection
						at:	eachEquality second index
				)
				ifFalse:
				[
					^ nil.
				].
		].

	^ key.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> normalizeKeyAccessors: aDictionary [
	|
		nonWholeRowAccessors
	|

	nonWholeRowAccessors :=
		(
			aDictionary values
				reject:	#isEmpty
		) asSet.

	nonWholeRowAccessors size = 1
		ifTrue:
		[
			aDictionary keys
				do:
				[ :eachTableIndex |
					(
						aDictionary
							at:	eachTableIndex
					)
						ifEmpty:
						[
							aDictionary
								at:	eachTableIndex
								put:	nonWholeRowAccessors anyOne.
						].
				].
		].

	^ aDictionary.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> parameterCandidateRowsWithArguments: aCollection [
	|
		key
		candidateRows
	|

	key :=
		self
			keyFromParameterEqualitiesWithArguments:	aCollection.

	key
		ifNil:
		[
			^ nil.
		].

	candidateRows := OrderedCollection new.

	tableIndexes
		do:
		[ :eachTableIndex |
			|
				row
			|

			row :=
				self
					rowMatchingParameterKey:	key
					inTable:	eachTableIndex
					using:	tableKeyAccessorsByTable.

			row
				ifNil:
				[
					^ nil.
				].

			candidateRows
				add:	row.
		].

	^ candidateRows.
]

{ #category : 'initialization' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> prepare [
	|
		keyAccessorsByTable
	|

	keyAccessorsByTable :=
		self
			tableKeyAccessorsFrom:	whereExpression.

	tableIndexes :=
		keyAccessorsByTable keys
			asSortedCollection.
	tableKeyAccessorsByTable := keyAccessorsByTable.

	parameterEqualities
		ifEmpty:
		[
			candidateValues :=
				self
					candidateRowsFor:	tableIndexes
					using:	keyAccessorsByTable.
		].

	^ self.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> requireConnectedIndexes: anIndexCollection
by: anEqualityCollection [
	|
		reachable
		changed
	|

	anIndexCollection
		ifEmpty:
		[
			self
				error:	'unsupported predicate'.
		].

	reachable :=
		OrderedCollection
			with:	anIndexCollection first.
	[
		changed := false.

		anEqualityCollection
			do:
			[ :eachEquality |
				(
					(
						reachable
							includes:	eachEquality first
					)
						and:
						[
							(
								reachable
									includes:	eachEquality second
							)
								not.
						]
				)
					ifTrue:
					[
						reachable
							add:	eachEquality second.

						changed := true.
					].

				(
					(
						reachable
							includes:	eachEquality second
					)
						and:
						[
							(
								reachable
									includes:	eachEquality first
							)
								not.
						]
				)
					ifTrue:
					[
						reachable
							add:	eachEquality first.

						changed := true.
					].
			].

		changed.
	] whileTrue.

	reachable
		size
		= anIndexCollection size
		ifFalse:
		[
			self
				error:	'unsupported predicate'.
		].
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> rowIndexForTable: anInteger
using: aTableKeySelectorDictionary [
	|
		accessor
		index
	|

	rowIndexesByTable
		at:	anInteger
		ifPresent:
		[ :existingIndex |
			^ existingIndex.
		].

	accessor :=
		aTableKeySelectorDictionary
			at:	anInteger.

	index := Dictionary new.

	(
		sourceCollections
			at:	anInteger
	)
		do:
		[ :eachRow |
			index
				at:
				(
					self
						keyFor:	eachRow
						accessor:	accessor
				)
				ifAbsentPut:
				[
					eachRow.
				].
		].

	rowIndexesByTable
		at:	anInteger
		put:	index.

	^ index.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> rowMatchingKey: anObject
inTable: anInteger
using: aTableKeySelectorDictionary [
	^
	(
		self
			rowIndexForTable:	anInteger
			using:	aTableKeySelectorDictionary
	)
		at:	anObject
		ifAbsent:
		[
			nil.
		].
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> rowMatchingParameterKey: anObject
inTable: anInteger
using: aTableKeySelectorDictionary [
	|
		accessor
	|

	accessor :=
		aTableKeySelectorDictionary
			at:	anInteger.

	^
	(
		sourceCollections
			at:	anInteger
	)
		detect:
		[ :eachRow |
			(
				self
					keyFor:	eachRow
					accessor:	accessor
			)
				= anObject.
		]
		ifNone:
		[
			nil.
		].
]

{ #category : 'initialization' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> setSources: aSourceCollection
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	sourceCollections := aSourceCollection.
	whereExpression := aWhereExpressionTableQueryRudesheim.
	selectExpression := aSelectExpressionTableQueryRudesheim.
	rowIndexesByTable := Dictionary new.
	parameterEqualities := OrderedCollection new.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> tableKeyAccessorsFrom: anExpressionTableQueryRudesheim [
	|
		equalities
		keyAccessorsByTable
		indexes
	|

	equalities := OrderedCollection new.

	anExpressionTableQueryRudesheim
		collectWholeRowEqualitiesRudesheim:	equalities
		forPlan:	self.

	keyAccessorsByTable := Dictionary new.

	equalities
		do:
		[ :eachEquality |
			eachEquality
				do:
				[ :eachOperand |
					|
						tableIndex
						keyAccessor
					|

					tableIndex := eachOperand tableIndex.
					keyAccessor := eachOperand keyAccessorPath.

					keyAccessorsByTable
						at:	tableIndex
						ifPresent:
						[ :existingAccessor |
							(
								existingAccessor isEmpty
									or:
									[
										keyAccessor isEmpty
											or:
											[
												existingAccessor = keyAccessor.
											].
									]
							)
								ifFalse:
								[
									self
										error:	'unsupported predicate'.
								].

							existingAccessor
								ifEmpty:
								[
									keyAccessorsByTable
										at:	tableIndex
										put:	keyAccessor.
								].
						]
						ifAbsentPut:
						[
							keyAccessor.
						].
				].
		].

	indexes := keyAccessorsByTable keys asOrderedCollection.

	self
		requireConnectedIndexes:	indexes
		by:
		(
			equalities
				collect:
				[ :eachEquality |
					eachEquality
						collect:	#tableIndex.
				]
		).

	^ self
		normalizeKeyAccessors:	keyAccessorsByTable.
]
