Class {
	#name : 'OSTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Table-Query-InMemory-Tests-OS',
	#package : 'Rudesheim-Table-Query-InMemory-Tests',
	#tag : 'OS'
}

{ #category : 'accessing' }
OSTableQueryRudesheimTest class >> targetClass [
	^ OSTableQueryRudesheim.
]

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
		assert:	self targetClass optimizers
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
			WinOSTableQueryRudesheim
				inheritsFrom:	self targetClass
		).
]

{ #category : 'tests' }
OSTableQueryRudesheimTest >> testWinOptimizersExcludeSmallInputAndEqualityIntersectionOnly [
	|
		plan
	|

	plan := Rudesheim TableQuery Backend InMemory Plan.

	self
		assert:	WinOSTableQueryRudesheim optimizers
		equals:
		{
			plan SmallInputSequential.
			plan EqualityIntersection
		}.
]
