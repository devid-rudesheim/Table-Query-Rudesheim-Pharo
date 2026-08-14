Class {
	#name : 'TableQueryRudesheim',
	#superclass : 'Object',
	#category : 'Rudesheim-Table-Query-Namespace',
	#package : 'Rudesheim-Table-Query',
	#tag : 'Namespace'
}

{ #category : 'namespace' }
TableQueryRudesheim class >> Backend [
	^ BackendTableQueryRudesheim.
]

{ #category : 'namespace' }
TableQueryRudesheim class >> EvaluatorForExpression [
	^ EvaluatorForExpressionTableQueryRudesheim.
]

{ #category : 'namespace' }
TableQueryRudesheim class >> Expression [
	^ ExpressionTableQueryRudesheim.
]

{ #category : 'namespace' }
TableQueryRudesheim class >> ExpressionCaptureDelegator [
	^ ExpressionCaptureDelegatorTableQueryRudesheim.
]

{ #category : 'namespace' }
TableQueryRudesheim class >> ExpressionCapturingStatement [
	^ ExpressionCapturingStatementTableQueryRudesheim.
]

{ #category : 'namespace' }
TableQueryRudesheim class >> Iterator [
	^ IteratorTableQueryRudesheim.
]

{ #category : 'namespace' }
TableQueryRudesheim class >> ParameterCapture [
	^ ParameterCaptureTableQueryRudesheim.
]

{ #category : 'namespace' }
TableQueryRudesheim class >> Query [
	^ QueryTableQueryRudesheim.
]

{ #category : 'namespace' }
TableQueryRudesheim class >> QuerySource [
	^ QuerySourceTableQueryRudesheim.
]
