Trait {
	#name : 'TBackendTableQueryRudesheim',
	#category : 'Rudesheim-Table-Query-Private-Backend',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Backend'
}

{ #category : 'preparing' }
TBackendTableQueryRudesheim classSide >> rowPlaceholdersFor: aCollection [
	|
		tableQuery
	|

	tableQuery := Rudesheim TableQuery.

	^
	(
		1
			to:	aCollection size
	)
		collect:
		[ :eachIndex |
			tableQuery ExpressionCaptureDelegator
				delegateTo:
				(
					tableQuery Expression Field
						table:	eachIndex
				).
		].
]

{ #category : 'evaluating' }
TBackendTableQueryRudesheim >> inquireTableQuery: aBlockClosure
from: aCollection [
	^
	(
		self
			prepareTableQuery:	aBlockClosure
			from:	aCollection
	)
		valueWithArguments:	#(  ).
]

{ #category : 'preparing' }
TBackendTableQueryRudesheim >> prepareTableQuery: aBlockClosure
from: aCollection [
	^ self subclassResponsibility.
]
