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
		assert:	Rudesheim TableQuery Backend InMemory PreparedQuery optimizers
		equals:	Smalltalk os rudesheim tableQuery optimizers.
]

{ #category : 'tests' }
OSTableQueryRudesheimTest >> testOSTableQueryRudesheimOptimizersIncludeDMirrorPlans [
	|
		plan
	|

	plan := Rudesheim TableQuery Backend InMemory Plan.

	self
		assert:
		OSTableQueryRudesheim optimizers
		equals:
		{
			plan SmallInputSequential.
			plan DMirror EqualityIntersection.
			plan EqualityIntersection.
			plan DMirror Sequential
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
	|
		plan
	|

	plan := Rudesheim TableQuery Backend InMemory Plan.

	self
		assert:
		WinOSTableQueryRudesheim optimizers
		equals:
		{
			plan SmallInputSequential.
			plan EqualityIntersection
		}.
]
