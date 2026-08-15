Class {
	#name : 'QueryTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewUtilityRudesheim',
	#classTraits : 'TShouldntNewUtilityRudesheim classTrait',
	#instVars : [
		'backend',
		'sourceCollections'
	],
	#category : 'Rudesheim-Table-Query-Query',
	#package : 'Rudesheim-Table-Query',
	#tag : 'Query'
}

{ #category : 'instance creation' }
QueryTableQueryRudesheim class >> fromCollections: aCollection
backend: aBackendTableQueryRudesheim [

	^ super new
		setCollections:	aCollection
		backend:	aBackendTableQueryRudesheim.
]

{ #category : 'evaluating' }
QueryTableQueryRudesheim >> inquireTableQuery: aBlockClosure [
	^ backend
		inquireTableQuery:	aBlockClosure
		from:	sourceCollections.
]

{ #category : 'evaluating' }
QueryTableQueryRudesheim >> prepareTableQuery: aBlockClosure [
	^ backend
		prepareTableQuery:	aBlockClosure
		from:	sourceCollections.
]

{ #category : 'initialization' }
QueryTableQueryRudesheim >> setCollections: aCollection
backend: aBackendTableQueryRudesheim [

	sourceCollections := aCollection.
	backend := aBackendTableQueryRudesheim.
	^ self.
]
