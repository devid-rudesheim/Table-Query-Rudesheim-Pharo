Extension { #name : 'ExpressionTableQueryRudesheim' }

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
ExpressionTableQueryRudesheim >> collectWholeRowEqualitiesRudesheim: anOrderedCollection
forPlan: anEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim [
	anEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim
		addEqualityFrom:	self
		to:	anOrderedCollection.
]

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
ExpressionTableQueryRudesheim >> equalityKeyOperandRudesheim [
	self error: 'unsupported predicate'.
]
