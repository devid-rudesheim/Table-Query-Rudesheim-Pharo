"
Test-support double: composes TBackendTableQueryRudesheim without overriding #prepareTableQuery:from:, to verify the required-method contract raises when unimplemented.
"
Class {
	#name : 'IncompleteBackendForTestTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TBackendTableQueryRudesheim',
	#classTraits : 'TBackendTableQueryRudesheim classTrait',
	#category : 'Rudesheim-Table-Query-Private-Tests-Support',
	#package : 'Rudesheim-Table-Query-Private-Tests',
	#tag : 'Support'
}
