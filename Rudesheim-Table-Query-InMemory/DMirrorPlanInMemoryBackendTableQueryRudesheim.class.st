Class {
	#name : 'DMirrorPlanInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#category : 'Rudesheim-Table-Query-InMemory-Plan',
	#package : 'Rudesheim-Table-Query-InMemory',
	#tag : 'Plan'
}

{ #category : 'namespace' }
DMirrorPlanInMemoryBackendTableQueryRudesheim class >> EqualityIntersection [
	^ DMirrorEqualityIntersectionPlanInMemoryBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
DMirrorPlanInMemoryBackendTableQueryRudesheim class >> Sequential [
	^ DMirrorSequentialPlanInMemoryBackendTableQueryRudesheim.
]
