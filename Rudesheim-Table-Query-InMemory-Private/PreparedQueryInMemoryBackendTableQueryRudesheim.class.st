Class {
	#name : 'PreparedQueryInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TCallableRudesheim + TShouldntNewRudesheim',
	#classTraits : 'TCallableRudesheim classTrait + TShouldntNewRudesheim classTrait',
	#instVars : [
		'sourceCollections',
		'whereExpression',
		'selectExpression'
	],
	#category : 'Rudesheim-Table-Query-InMemory-Private-Query',
	#package : 'Rudesheim-Table-Query-InMemory-Private',
	#tag : 'Query'
}

{ #category : 'instance creation' }
PreparedQueryInMemoryBackendTableQueryRudesheim class >> fromCollections: aCollection
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	^ super new
		setSourceCollections:	aCollection
		where:	aWhereExpressionTableQueryRudesheim
		select:	aSelectExpressionTableQueryRudesheim.
]

{ #category : 'optimization' }
PreparedQueryInMemoryBackendTableQueryRudesheim class >> optimizers [
	|
		plan
	|

	plan :=
		Rudesheim
			TableQuery
			Backend
			InMemory
			Plan.

	^
	{
		plan SmallInputSequential.
		plan DMirror EqualityIntersection.
		plan EqualityIntersection.
		plan DMirror Sequential
	}.
]

{ #category : 'optimization' }
PreparedQueryInMemoryBackendTableQueryRudesheim >> optimizationContext [
	^ Rudesheim TableQuery Backend InMemory OptimizationContext
		sources:	sourceCollections
		where:	whereExpression
		select:	selectExpression.
]

{ #category : 'optimization' }
PreparedQueryInMemoryBackendTableQueryRudesheim >> planFor: anOptimizationContextInMemoryBackendTableQueryRudesheim [
	|
		plan
	|

	plan :=
		Rudesheim
			TableQuery
			Backend
			InMemory
			Plan.

	^
	(
		self class optimizers
			detect:
			[ :eachOptimizer |
				eachOptimizer
					canOptimize:	anOptimizationContextInMemoryBackendTableQueryRudesheim.
			]
			ifNone:
			[
				plan Sequential.
			]
	)
		for:	anOptimizationContextInMemoryBackendTableQueryRudesheim.
]

{ #category : 'initialization' }
PreparedQueryInMemoryBackendTableQueryRudesheim >> setSourceCollections: aCollection
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	sourceCollections := aCollection.
	whereExpression := aWhereExpressionTableQueryRudesheim.
	selectExpression := aSelectExpressionTableQueryRudesheim.
]

{ #category : 'evaluating' }
PreparedQueryInMemoryBackendTableQueryRudesheim >> valueWithArguments: aCollection [
	^
	(
		self
			planFor:	self optimizationContext
	)
		executeWithArguments:	aCollection.
]
