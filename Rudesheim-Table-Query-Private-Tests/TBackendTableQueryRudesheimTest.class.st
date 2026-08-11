Class {
	#name : 'TBackendTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Table-Query-Private-Tests-Backend',
	#package : 'Rudesheim-Table-Query-Private-Tests',
	#tag : 'Backend'
}

{ #category : 'accessing' }
TBackendTableQueryRudesheimTest class >> targetClass [
	^ DummyBackendForTestTableQueryRudesheim.
]

{ #category : 'tests' }
TBackendTableQueryRudesheimTest >> testInquireTableQueryFromDelegatesToPrepareWithNoArguments [
	|
		aBlockClosure
		aCollection
		result
	|

	aBlockClosure :=
		[ :statement :rows :parameters |
		].

	aCollection := {1 .  2}.

	result :=
		self basicTarget
			inquireTableQuery:	aBlockClosure
			from:	aCollection.

	self
		assert:
		self
			basicTarget
			lastBlockClosure
			== aBlockClosure.

	self
		assert:
		self
			basicTarget
			lastCollection
			== aCollection.

	self
		assert:
		self
			basicTarget
			preparedQuery
			lastArguments
		equals:	#().

	self
		assert:	result
		equals:	#().
]

{ #category : 'tests' }
TBackendTableQueryRudesheimTest >> testPrepareTableQueryFromIsSubclassResponsibility [
	self
		should:
		[
			IncompleteBackendForTestTableQueryRudesheim new
				prepareTableQuery:
				[
				]
				from:	#().
		]
		raise:	Error.
]
