"
A RHTQIteratorTest is a test class for testing the behavior of RHTQIterator
"
Class {
	#name : 'IteratorTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#instVars : [
		'sourceCollections',
		'expectCount'
	],
	#category : 'Rudesheim-Table-Query-Private-Tests-Query',
	#package : 'Rudesheim-Table-Query-Private-Tests',
	#tag : 'Query'
}

{ #category : 'accessing' }
IteratorTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim
		TableQuery
		Iterator.
]

{ #category : 'accessing' }
IteratorTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		fromCollections:	self sourceCollections.
]

{ #category : 'accessing' }
IteratorTableQueryRudesheimTest >> defaultExpectCount [
	^ 0.
]

{ #category : 'accessing' }
IteratorTableQueryRudesheimTest >> defaultSourceCollections [
	^ {{} .  {{}} .  {{} .  {}}}.
]

{ #category : 'accessing' }
IteratorTableQueryRudesheimTest >> expectCount [
	^ expectCount
		ifNil:
		[
			expectCount := self defaultExpectCount.
		].
]

{ #category : 'accessing' }
IteratorTableQueryRudesheimTest >> expectCount: anObject [
	expectCount := anObject.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> runRows0 [
	self
		assert:	self expectCount
		equals:
		self
			basicTarget
			rows
			size.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> runTimesRepeat0 [
	|
		count
		block
	|

	count := 0.

	block :=
		[
			count := 1 + count.
		].

	self basicTarget
		timesRepeat:	block.

	self
		assert:	self expectCount
		equals:	count.
]

{ #category : 'running' }
IteratorTableQueryRudesheimTest >> setUp [
	super setUp.

	self
		expectCount:	3;
		sourceCollections:	nil.
]

{ #category : 'accessing' }
IteratorTableQueryRudesheimTest >> sourceCollections [
	^ sourceCollections
		ifNil:
		[
			sourceCollections := self defaultSourceCollections.
		].
]

{ #category : 'accessing' }
IteratorTableQueryRudesheimTest >> sourceCollections: anObject [
	sourceCollections := anObject.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testRows [
	self
		testRows0_0;
		tearDown;
		setUp;
		testRows0_1;
		tearDown;
		setUp;
		testRows0_2;
		tearDown;
		setUp;
		testRows0_3;
		tearDown;
		setUp;
		testRows0_4;
		tearDown;
		setUp;
		testRows0_5.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testRows0_0 [
	self
		sourceCollections:	#();
		expectCount:	0;
		runRows0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testRows0_1 [
	self
		sourceCollections:	#(#(1));
		expectCount:	1;
		runRows0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testRows0_2 [
	self
		sourceCollections:	#(#(1 2));
		expectCount:	1;
		runRows0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testRows0_3 [
	self
		sourceCollections:	#(#() #());
		expectCount:	2;
		runRows0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testRows0_4 [
	self
		sourceCollections:	#(#(1) #(1));
		expectCount:	2;
		runRows0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testRows0_5 [
	self
		sourceCollections:	#(#(1 2) #(1 2));
		expectCount:	2;
		runRows0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testTimesRepeat [
	self
		testTimesRepeat0_0;
		tearDown;
		setUp;
		testTimesRepeat0_1;
		tearDown;
		setUp;
		testTimesRepeat0_2;
		tearDown;
		setUp;
		testTimesRepeat0_3;
		tearDown;
		setUp;
		testTimesRepeat0_4;
		tearDown;
		setUp;
		testTimesRepeat0_5;
		tearDown;
		setUp;
		testTimesRepeat0_6.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testTimesRepeat0_0 [
	self
		sourceCollections:	#();
		expectCount:	0;
		runTimesRepeat0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testTimesRepeat0_1 [
	self
		sourceCollections:	#(#());
		expectCount:	0;
		runTimesRepeat0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testTimesRepeat0_2 [
	self
		sourceCollections:	#(#(1));
		expectCount:	1;
		runTimesRepeat0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testTimesRepeat0_3 [
	self
		sourceCollections:	#(#(1 2));
		expectCount:	2;
		runTimesRepeat0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testTimesRepeat0_4 [
	self
		sourceCollections:	#(#() #());
		expectCount:	0;
		runTimesRepeat0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testTimesRepeat0_5 [
	self
		sourceCollections:	#(#(1) #(1));
		expectCount:	1;
		runTimesRepeat0.
]

{ #category : 'tests' }
IteratorTableQueryRudesheimTest >> testTimesRepeat0_6 [
	self
		sourceCollections:	#(#(1 2) #(1 2));
		expectCount:	4;
		runTimesRepeat0.
]
