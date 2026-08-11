"
Test-support double: a TBackendTableQueryRudesheim implementation that records the block/tables it was asked to prepare and returns a CannedPreparedQueryForTestTableQueryRudesheim.
"
Class {
	#name : 'DummyBackendForTestTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TBackendTableQueryRudesheim',
	#classTraits : 'TBackendTableQueryRudesheim classTrait',
	#instVars : [
		'lastBlockClosure',
		'lastCollection',
		'preparedQuery'
	],
	#category : 'Rudesheim-Table-Query-Private-Tests-Support',
	#package : 'Rudesheim-Table-Query-Private-Tests',
	#tag : 'Support'
}

{ #category : 'initialization' }
DummyBackendForTestTableQueryRudesheim >> initialize [
	super initialize.
	preparedQuery := CannedPreparedQueryForTestTableQueryRudesheim new.
]

{ #category : 'accessing' }
DummyBackendForTestTableQueryRudesheim >> lastBlockClosure [
	^ lastBlockClosure.
]

{ #category : 'accessing' }
DummyBackendForTestTableQueryRudesheim >> lastCollection [
	^ lastCollection.
]

{ #category : 'preparing' }
DummyBackendForTestTableQueryRudesheim >> prepareTableQuery: aBlockClosure
from: aCollection [
	lastBlockClosure := aBlockClosure.
	lastCollection := aCollection.
	^ preparedQuery.
]

{ #category : 'accessing' }
DummyBackendForTestTableQueryRudesheim >> preparedQuery [
	^ preparedQuery.
]
