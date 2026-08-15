Class {
	#name : 'OSTableQueryRudesheimTest',
	#superclass : 'TestCase',
	#category : 'Rudesheim-Table-Query-InMemory-Tests-OS',
	#package : 'Rudesheim-Table-Query-InMemory-Tests',
	#tag : 'OS'
}

{ #category : 'tests' }
OSTableQueryRudesheimTest >> testDelegatesThroughRudesheimOSDispatch [
	self
		assert:	PreparedQueryInMemoryBackendTableQueryRudesheim optimizers
		equals:	Smalltalk os rudesheim tableQuery optimizers.
]

{ #category : 'tests' }
OSTableQueryRudesheimTest >> testOSTableQueryRudesheimOptimizersIncludeDMirrorPlans [
	self
		assert:
		OSTableQueryRudesheim optimizers
		equals:
		{
			Rudesheim TableQuery Backend InMemory Plan SmallInputSequential.
			Rudesheim TableQuery Backend InMemory Plan DMirror EqualityIntersection.
			Rudesheim TableQuery Backend InMemory Plan EqualityIntersection.
			Rudesheim TableQuery Backend InMemory Plan DMirror Sequential
		}.
]

{ #category : 'tests' }
OSTableQueryRudesheimTest >> testWinOverridesOSTableQueryRudesheim [
	self
		assert:
		(
			WinOSTableQueryRudesheim inheritsFrom: OSTableQueryRudesheim
		).
]

{ #category : 'tests' }
OSTableQueryRudesheimTest >> testWinOptimizersExcludeSmallInputAndEqualityIntersectionOnly [
	self
		assert:
		WinOSTableQueryRudesheim optimizers
		equals:
		{
			Rudesheim TableQuery Backend InMemory Plan SmallInputSequential.
			Rudesheim TableQuery Backend InMemory Plan EqualityIntersection
		}.
]
