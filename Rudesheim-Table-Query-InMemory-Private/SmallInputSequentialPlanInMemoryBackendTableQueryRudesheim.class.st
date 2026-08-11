Class {
	#name : 'SmallInputSequentialPlanInMemoryBackendTableQueryRudesheim',
	#superclass : 'SequentialPlanInMemoryBackendTableQueryRudesheim',
	#category : 'Rudesheim-Table-Query-InMemory-Private-Optimization',
	#package : 'Rudesheim-Table-Query-InMemory-Private',
	#tag : 'Optimization'
}

{ #category : 'testing' }
SmallInputSequentialPlanInMemoryBackendTableQueryRudesheim class >> canOptimize: anOptimizationContextInMemoryBackendTableQueryRudesheim [
	|
		combinationSize
	|

	combinationSize := 1.

	anOptimizationContextInMemoryBackendTableQueryRudesheim sourceCollections
		do:
		[ :eachCollection |
			combinationSize := combinationSize * eachCollection size.

			combinationSize > self maximumCombinationSize
				ifTrue:
				[
					^ false.
				].
		].

	^ true.
]

{ #category : 'accessing' }
SmallInputSequentialPlanInMemoryBackendTableQueryRudesheim class >> maximumCombinationSize [
	^ 1000.
]
