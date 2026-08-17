Class {
	#name : 'SequentialPlanInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewRudesheim',
	#classTraits : 'TShouldntNewRudesheim classTrait',
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
SequentialPlanInMemoryBackendTableQueryRudesheim class >> for: anOptimizationContextInMemoryBackendTableQueryRudesheim [
	^ self
		sources:	anOptimizationContextInMemoryBackendTableQueryRudesheim sourceCollections
		where:	anOptimizationContextInMemoryBackendTableQueryRudesheim whereExpression
		select:	anOptimizationContextInMemoryBackendTableQueryRudesheim selectExpression.
]

{ #category : 'instance creation' }
SequentialPlanInMemoryBackendTableQueryRudesheim class >> sources: aSourceCollection
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	^ super new
		setSources:	aSourceCollection
		where:	aWhereExpressionTableQueryRudesheim
		select:	aSelectExpressionTableQueryRudesheim.
]

{ #category : 'executing' }
SequentialPlanInMemoryBackendTableQueryRudesheim >> executeWithArguments: aCollection [
	|
		iterator
		results
		block
		tableQuery
	|
	
	tableQuery := Rudesheim TableQuery.

	iterator :=
		tableQuery Iterator
			fromCollections:	sourceCollections.

	results := OrderedCollection new.

	block :=
		[
			|
				evaluator
			|

			evaluator :=
				tableQuery EvaluatorForExpression
					rows:	iterator rows
					parameters:	aCollection.

			(
				evaluator
					visit:	whereExpression
			)
				ifTrue:
				[
					results
						add:
						(
							evaluator
								visit:	selectExpression
						).
				].
		].

	iterator
		timesRepeat:	block.

	^ results.
]

{ #category : 'initialization' }
SequentialPlanInMemoryBackendTableQueryRudesheim >> setSources: aSourceCollection
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	sourceCollections := aSourceCollection.
	whereExpression := aWhereExpressionTableQueryRudesheim.
	selectExpression := aSelectExpressionTableQueryRudesheim.
]
