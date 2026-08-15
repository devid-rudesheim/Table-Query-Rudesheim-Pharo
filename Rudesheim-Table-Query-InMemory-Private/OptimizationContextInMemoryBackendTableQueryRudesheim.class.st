Class {
	#name : 'OptimizationContextInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewUtilityRudesheim',
	#classTraits : 'TShouldntNewUtilityRudesheim classTrait',
	#instVars : [
		'sourceCollections',
		'whereExpression',
		'selectExpression'
	],
	#category : 'Rudesheim-Table-Query-InMemory-Private-Optimization',
	#package : 'Rudesheim-Table-Query-InMemory-Private',
	#tag : 'Optimization'
}

{ #category : 'instance creation' }
OptimizationContextInMemoryBackendTableQueryRudesheim class >> sources: aSourceCollection
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	^ super new
		setSources:	aSourceCollection
		where:	aWhereExpressionTableQueryRudesheim
		select:	aSelectExpressionTableQueryRudesheim.
]

{ #category : 'accessing' }
OptimizationContextInMemoryBackendTableQueryRudesheim >> selectExpression [
	^ selectExpression.
]

{ #category : 'initialization' }
OptimizationContextInMemoryBackendTableQueryRudesheim >> setSources: aSourceCollection
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	sourceCollections := aSourceCollection.
	whereExpression := aWhereExpressionTableQueryRudesheim.
	selectExpression := aSelectExpressionTableQueryRudesheim.
]

{ #category : 'accessing' }
OptimizationContextInMemoryBackendTableQueryRudesheim >> sourceCollections [
	^ sourceCollections.
]

{ #category : 'accessing' }
OptimizationContextInMemoryBackendTableQueryRudesheim >> whereExpression [
	^ whereExpression.
]
