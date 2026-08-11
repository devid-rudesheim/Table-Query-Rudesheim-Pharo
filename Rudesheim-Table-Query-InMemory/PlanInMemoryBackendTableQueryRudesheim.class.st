Class {
	#name : 'PlanInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#category : 'Rudesheim-Table-Query-InMemory-Plan',
	#package : 'Rudesheim-Table-Query-InMemory',
	#tag : 'Plan'
}

{ #category : 'namespace' }
PlanInMemoryBackendTableQueryRudesheim class >> DMirror [
	^ DMirrorPlanInMemoryBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
PlanInMemoryBackendTableQueryRudesheim class >> EqualityIntersection [
	^ EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
PlanInMemoryBackendTableQueryRudesheim class >> Sequential [
	^ SequentialPlanInMemoryBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
PlanInMemoryBackendTableQueryRudesheim class >> SmallInputSequential [
	^ SmallInputSequentialPlanInMemoryBackendTableQueryRudesheim.
]
