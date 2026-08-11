Trait {
	#name : 'TBackendTableQueryRudesheim',
	#category : 'Rudesheim-Table-Query-Private-Backend',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Backend'
}

{ #category : 'evaluating' }
TBackendTableQueryRudesheim >> inquireTableQuery: aBlockClosure
from: aCollection [
	^
	(
		self
			prepareTableQuery:	aBlockClosure
			from:	aCollection
	)
		valueWithArguments:	#().
]

{ #category : 'preparing' }
TBackendTableQueryRudesheim >> prepareTableQuery: aBlockClosure
from: aCollection [
	^ self subclassResponsibility.
]
