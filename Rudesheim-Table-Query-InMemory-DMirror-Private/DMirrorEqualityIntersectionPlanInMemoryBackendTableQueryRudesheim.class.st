Class {
	#name : 'DMirrorEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim',
	#superclass : 'EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim',
	#category : 'Rudesheim-Table-Query-InMemory-DMirror-Private-Optimization',
	#package : 'Rudesheim-Table-Query-InMemory-DMirror-Private',
	#tag : 'Optimization'
}

{ #category : 'testing' }
DMirrorEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim class >> canOptimize: anOptimizationContextInMemoryBackendTableQueryRudesheim [
	^
	[
		|
			keyAccessorsByTable
			plan
		|

		(
			Rudesheim TableQuery Backend InMemory DMirrorSupport
				minimumCollectionSizeOf:	anOptimizationContextInMemoryBackendTableQueryRudesheim sourceCollections
		) < self minimumDriverSize
			ifTrue:
			[
				^ false.
			].

		plan :=
			self
				sources:	anOptimizationContextInMemoryBackendTableQueryRudesheim sourceCollections
				where:	anOptimizationContextInMemoryBackendTableQueryRudesheim whereExpression
				select:	anOptimizationContextInMemoryBackendTableQueryRudesheim selectExpression.

		keyAccessorsByTable :=
			plan
				tableKeyAccessorsFrom:	anOptimizationContextInMemoryBackendTableQueryRudesheim whereExpression.

		plan hasParameterEqualities
			ifTrue:
			[
				^ false.
			].

		keyAccessorsByTable size = anOptimizationContextInMemoryBackendTableQueryRudesheim sourceCollections size.
	]
		on:	Error
		do:
		[ :anError |
			false.
		].
]

{ #category : 'accessing' }
DMirrorEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim class >> minimumDriverSize [
	^ 1000000.
]

{ #category : 'executing' }
DMirrorEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> executeWithArguments: aCollection [
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
DMirrorEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim >> executeWithDMirrorWithArguments: aCollection [
	
	Rudesheim TableQuery Backend InMemory DMirrorSupport ensurePlayCacheDirectory.

	^
	(
		DMirror
			runMirror:
			[ :eachCandidateChunk |
				self
					executeCandidateValues:	eachCandidateChunk
					withArguments:	aCollection.
			]
			workloadArray:
			(
				DMirror
					splitArray:	candidateValues asArray
			)
	)
		flatCollect:
		[ :eachResult |
			eachResult.
		].
]
