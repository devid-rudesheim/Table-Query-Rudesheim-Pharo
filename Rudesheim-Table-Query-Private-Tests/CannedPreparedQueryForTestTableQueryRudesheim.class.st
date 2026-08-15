"
Test-support double: a TCallableUtilityRudesheim implementation that records the arguments it was invoked with.
"
Class {
	#name : 'CannedPreparedQueryForTestTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TCallableUtilityRudesheim',
	#classTraits : 'TCallableUtilityRudesheim classTrait',
	#instVars : [
		'lastArguments'
	],
	#category : 'Rudesheim-Table-Query-Private-Tests-Support',
	#package : 'Rudesheim-Table-Query-Private-Tests',
	#tag : 'Support'
}

{ #category : 'accessing' }
CannedPreparedQueryForTestTableQueryRudesheim >> lastArguments [
	^ lastArguments.
]

{ #category : 'evaluating' }
CannedPreparedQueryForTestTableQueryRudesheim >> valueWithArguments: aCollection [
	lastArguments := aCollection.
	^ lastArguments.
]
