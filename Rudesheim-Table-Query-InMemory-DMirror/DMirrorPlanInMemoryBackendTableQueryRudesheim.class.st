Class {
	#name : 'DMirrorPlanInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#category : 'Rudesheim-Table-Query-InMemory-DMirror-Plan',
	#package : 'Rudesheim-Table-Query-InMemory-DMirror',
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
