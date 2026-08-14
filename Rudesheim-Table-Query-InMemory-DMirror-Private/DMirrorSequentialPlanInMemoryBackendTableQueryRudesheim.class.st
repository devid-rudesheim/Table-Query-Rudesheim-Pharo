Class {
	#name : 'DMirrorSequentialPlanInMemoryBackendTableQueryRudesheim',
	#superclass : 'SequentialPlanInMemoryBackendTableQueryRudesheim',
	#category : 'Rudesheim-Table-Query-InMemory-DMirror-Private-Optimization',
	#package : 'Rudesheim-Table-Query-InMemory-DMirror-Private',
	#tag : 'Optimization'
}

{ #category : 'testing' }
DMirrorSequentialPlanInMemoryBackendTableQueryRudesheim class >> canOptimize: anOptimizationContextInMemoryBackendTableQueryRudesheim [
	^
	(
		Rudesheim TableQuery Backend InMemory DMirrorSupport
			combinationSizeOf:	anOptimizationContextInMemoryBackendTableQueryRudesheim sourceCollections
	)
		>= self minimumCombinationSize.
]

{ #category : 'accessing' }
DMirrorSequentialPlanInMemoryBackendTableQueryRudesheim class >> minimumCombinationSize [
	^ 1000000.
]

{ #category : 'executing' }
DMirrorSequentialPlanInMemoryBackendTableQueryRudesheim >> executeWithArguments: aCollection [
	^
	[
		self
			executeWithDMirrorWithArguments:	aCollection.
	]
		on:	DMirrorExternalError
		do:
		[ :anError |
			super
				executeWithArguments:	aCollection.
		].
]

{ #category : 'executing' }
DMirrorSequentialPlanInMemoryBackendTableQueryRudesheim >> executeWithDMirrorWithArguments: aCollection [
	|
		inMemory
	|
	
	inMemory := 	Rudesheim TableQuery Backend InMemory.
	
	inMemory DMirrorSupport ensurePlayCacheDirectory.

	^
	(
		DMirror
			runMirror:
			[ :eachSourceChunk |
				|
					workerSourceCollections
				|

				workerSourceCollections := sourceCollections copy.
				workerSourceCollections
					at:	1
					put:	eachSourceChunk.

				(
					inMemory Plan Sequential
						sources:	workerSourceCollections
						where:	whereExpression
						select:	selectExpression
				)
					executeWithArguments:	aCollection.
			]
			workloadArray:
			(
				DMirror
					splitArray:	sourceCollections first asArray
			)
	)
		flatCollect:
		[ :eachResult |
			eachResult.
		].
]
