"
An ExpressionCapturingStatementTableQueryRudesheim is the ""statement"" argument handed to a #prepareTableQuery:from: capture block. It evaluates each block exactly once against symbolic rows/parameters and stores the resulting expression trees.
"
Class {
	#name : 'ExpressionCapturingStatementTableQueryRudesheim',
	#superclass : 'Object',
	#instVars : [
		'whereExpression',
		'selectExpression'
	],
	#category : 'Rudesheim-Table-Query-Private-Statement',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Statement'
}

{ #category : 'evaluating' }
ExpressionCapturingStatementTableQueryRudesheim >> collect: aCollectBlock [
	whereExpression :=
		Rudesheim TableQuery Expression Constant
			value:	true.

	selectExpression :=
		aCollectBlock value
			peekDelegateRudesheim
			asTableQueryProjectionExpressionRudesheim.
]

{ #category : 'evaluating' }
ExpressionCapturingStatementTableQueryRudesheim >> select: aWhereBlock
collect: aCollectBlock [
	whereExpression :=
		aWhereBlock value
			peekDelegateRudesheim.

	selectExpression :=
		aCollectBlock value
			peekDelegateRudesheim
			asTableQueryProjectionExpressionRudesheim.
]

{ #category : 'accessing' }
ExpressionCapturingStatementTableQueryRudesheim >> selectExpression [
	^ selectExpression.
]

{ #category : 'accessing' }
ExpressionCapturingStatementTableQueryRudesheim >> whereExpression [
	^ whereExpression.
]
