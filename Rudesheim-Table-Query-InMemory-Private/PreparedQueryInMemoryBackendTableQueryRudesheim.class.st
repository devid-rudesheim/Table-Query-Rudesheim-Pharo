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
	^ Smalltalk os rudesheim tableQuery optimizers.
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
				Rudesheim TableQuery Backend InMemory Plan Sequential.
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
