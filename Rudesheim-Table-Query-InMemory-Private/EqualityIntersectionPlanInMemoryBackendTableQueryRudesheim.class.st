Class {
	#name : 'EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewRudesheim',
	#classTraits : 'TShouldntNewRudesheim classTrait',
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
	|
		leftOperand
		rightOperand
	|

	aBinaryExpressionTableQueryRudesheim selector = #=
		ifFalse:
		[
			self
				error:	'unsupported predicate'.
		].

	leftOperand :=
		self
			keyOperandFrom:	aBinaryExpressionTableQueryRudesheim receiver.

	rightOperand :=
		self
			keyOperandFrom:	aBinaryExpressionTableQueryRudesheim argument.

	(
		(
			self
				isTableKeyOperand:	leftOperand
		)
			and:
			[
				self
					isTableKeyOperand:	rightOperand.
			]
	)
		ifTrue:
		[
			anOrderedCollection
				add:
				{
					leftOperand.
					rightOperand
				}.

			^ self.
		].

	(
		(
			self
				isTableKeyOperand:	leftOperand
		)
			and:
			[
				self
					isParameterOperand:	rightOperand.
			]
	)
		ifTrue:
		[
			parameterEqualities
				add:
				{
					leftOperand.
					rightOperand
				}.

			^ self.
		].

	(
		(
			self
				isParameterOperand:	leftOperand
		)
			and:
			[
				self
					isTableKeyOperand:	rightOperand.
			]
	)
		ifTrue:
		[
			parameterEqualities
				add:
				{
					rightOperand.
					leftOperand
				}.

			^ self.
		].

	self
		error:	'unsupported predicate'.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> addWholeRowEqualitiesFrom: anExpressionTableQueryRudesheim
to: anOrderedCollection [ 
	(
		anExpressionTableQueryRudesheim class == Rudesheim TableQuery Expression Binary
			and:
			[
				anExpressionTableQueryRudesheim selector = #&.
			]
	)
		ifTrue:
		[
			self
				addWholeRowEqualitiesFrom:	anExpressionTableQueryRudesheim receiver
				to:	anOrderedCollection.

			self
				addWholeRowEqualitiesFrom:	anExpressionTableQueryRudesheim argument
				to:	anOrderedCollection.

			^ self.
		].

	self
		addEqualityFrom:	anExpressionTableQueryRudesheim
		to:	anOrderedCollection.
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
					indexOf:	tableOperand first.
			row :=
				aCandidateRowCollection
					at:	tablePosition.
			key :=
				self
					keyFor:	row
					accessor:	tableOperand second.

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
							allSatisfy:
							[ :eachRow |
								eachRow notNil.
							]
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
						EvaluatorForExpressionTableQueryRudesheim
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
	parameterEqualities isEmpty
		ifFalse:
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

{ #category : 'testing' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> isParameterOperand: anObject [
	^ anObject class == Rudesheim TableQuery Expression Parameter.
]

{ #category : 'testing' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> isTableKeyOperand: anObject [
	^ anObject class == Array.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> keyAccessorFromFieldExpression: aFieldExpressionTableQueryRudesheim [
	^ aFieldExpressionTableQueryRudesheim fieldSelector
		ifNil:
		[
			#().
		]
		ifNotNil:
		[ :aFieldSelector |
			Array
				with:	aFieldSelector.
		].
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
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> keyOperandFrom: anExpressionTableQueryRudesheim [
	anExpressionTableQueryRudesheim class == FieldExpressionTableQueryRudesheim
		ifTrue:
		[
			^
			{
				anExpressionTableQueryRudesheim tableIndex.
				self
					keyAccessorFromFieldExpression:	anExpressionTableQueryRudesheim
			}.
		].

	anExpressionTableQueryRudesheim class == MessageExpressionTableQueryRudesheim
		ifTrue:
		[
			|
				receiverOperand
			|

			(
				anExpressionTableQueryRudesheim selector isUnary
					and:
					[
						anExpressionTableQueryRudesheim arguments isEmpty.
					]
			)
				ifFalse:
				[
					self
						error:	'unsupported predicate'.
				].

			receiverOperand :=
				self
					keyOperandFrom:	anExpressionTableQueryRudesheim receiver.

			(
				self
					isTableKeyOperand:	receiverOperand
			)
				ifFalse:
				[
					self
						error:	'unsupported predicate'.
				].

			^
			{
				receiverOperand first.
				receiverOperand second
					copyWith:	anExpressionTableQueryRudesheim selector
			}.
		].

	anExpressionTableQueryRudesheim class == ParameterExpressionTableQueryRudesheim
		ifTrue:
		[
			^ anExpressionTableQueryRudesheim.
		].

	self
		error:	'unsupported predicate'.
]

{ #category : 'private' }
EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> normalizeKeyAccessors: aDictionary [
	|
		nonWholeRowAccessors
	|

	nonWholeRowAccessors :=
		(
			aDictionary values
				reject:
				[ :eachAccessor |
					eachAccessor isEmpty.
				]
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
						isEmpty
						ifTrue:
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

	parameterEqualities isEmpty
		ifTrue:
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

	anIndexCollection isEmpty
		ifTrue:
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

	self
		addWholeRowEqualitiesFrom:	anExpressionTableQueryRudesheim
		to:	equalities.

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

					tableIndex := eachOperand first.
					keyAccessor := eachOperand second.

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

							existingAccessor isEmpty
								ifTrue:
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
						collect:
						[ :eachOperand |
							eachOperand first.
						].
				]
		).

	^ self
		normalizeKeyAccessors:	keyAccessorsByTable.
]
