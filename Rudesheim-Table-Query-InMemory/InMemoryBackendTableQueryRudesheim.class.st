Class {
	#name : 'InMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewRudesheim',
	#classTraits : 'TBackendTableQueryRudesheim classTrait + TShouldntNewRudesheim classTrait',
	#category : 'Rudesheim-Table-Query-InMemory-Backend',
	#package : 'Rudesheim-Table-Query-InMemory',
	#tag : 'Backend'
}

{ #category : 'namespace' }
InMemoryBackendTableQueryRudesheim class >> Plan [
	^ PlanInMemoryBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
InMemoryBackendTableQueryRudesheim class >> PreparedQuery [
	^ PreparedQueryInMemoryBackendTableQueryRudesheim.
]

{ #category : 'evaluating' }
InMemoryBackendTableQueryRudesheim class >> inquireTableQuery: aBlockClosure
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
InMemoryBackendTableQueryRudesheim class >> prepareTableQuery: aBlockClosure
from: aCollection [
	|
		statement
		rows
		parameters
	|

	statement := ExpressionCapturingStatementTableQueryRudesheim new.

	rows :=
		(
			1
				to:	aCollection size
		)
			collect:
			[ :eachCollectionIndex |
				FieldExpressionTableQueryRudesheim
					table:	eachCollectionIndex.
			].

	parameters := ParameterCaptureTableQueryRudesheim new.

	aBlockClosure
		cull:	statement
		cull:	rows asArray
		cull:	parameters.

	^ PreparedQueryInMemoryBackendTableQueryRudesheim
		fromCollections:	aCollection
		where:	statement whereExpression
		select:	statement selectExpression.
]
