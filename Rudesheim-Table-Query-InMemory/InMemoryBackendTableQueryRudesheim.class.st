Class {
	#name : 'InMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewUtilityRudesheim',
	#classTraits : 'TBackendTableQueryRudesheim classTrait + TShouldntNewUtilityRudesheim classTrait',
	#category : 'Rudesheim-Table-Query-InMemory-Backend',
	#package : 'Rudesheim-Table-Query-InMemory',
	#tag : 'Backend'
}

{ #category : 'namespace' }
InMemoryBackendTableQueryRudesheim class >> DMirrorSupport [
	^ DMirrorSupportInMemoryBackendTableQueryRudesheim
]

{ #category : 'namespace' }
InMemoryBackendTableQueryRudesheim class >> OptimizationContext [
	^ OptimizationContextInMemoryBackendTableQueryRudesheim
]

{ #category : 'namespace' }
InMemoryBackendTableQueryRudesheim class >> Plan [
	^ PlanInMemoryBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
InMemoryBackendTableQueryRudesheim class >> PreparedQuery [
	^ PreparedQueryInMemoryBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
InMemoryBackendTableQueryRudesheim class >> TableKeyOperand [
	^ TableKeyOperandInMemoryBackendTableQueryRudesheim.
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
		tableQuery
	|
	
	tableQuery := Rudesheim TableQuery.

	statement := tableQuery ExpressionCapturingStatement new.

	rows :=
		self
			rowPlaceholdersFor:	aCollection.

	parameters := tableQuery ParameterCapture new.

	aBlockClosure
		cull:	statement
		cull:	rows asArray
		cull:	parameters.

	^ tableQuery Backend InMemory PreparedQuery
		fromCollections:	aCollection
		where:	statement whereExpression
		select:	statement selectExpression.
]
