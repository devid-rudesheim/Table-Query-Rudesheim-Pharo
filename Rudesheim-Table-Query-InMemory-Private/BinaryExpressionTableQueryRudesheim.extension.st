Extension { #name : 'BinaryExpressionTableQueryRudesheim' }

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
BinaryExpressionTableQueryRudesheim >> collectWholeRowEqualitiesRudesheim: anOrderedCollection
forPlan: anEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim [
	#& = self selector
		ifFalse:
		[
			^ super
				collectWholeRowEqualitiesRudesheim:	anOrderedCollection
				forPlan:	anEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim.
		].

	{
		self receiver.
		self argument
	}
		do:
		[ :each |
			each
				collectWholeRowEqualitiesRudesheim:	anOrderedCollection
				forPlan:	anEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim.
		].
]
