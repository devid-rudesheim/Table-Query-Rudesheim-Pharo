Class {
	#name : 'ProjectionExpressionTableQueryRudesheim',
	#superclass : 'ExpressionTableQueryRudesheim',
	#instVars : [
		'expressions'
	],
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'instance creation' }
ProjectionExpressionTableQueryRudesheim class >> expressions: aCollection [
	^ self new
		setExpressions:	aCollection.
]

{ #category : 'visiting' }
ProjectionExpressionTableQueryRudesheim >> acceptTVisitorRudesheim: aTVisitorRudesheim [
	^ aTVisitorRudesheim
		visitProjectionExpressionRudesheim:	self.
]

{ #category : 'accessing' }
ProjectionExpressionTableQueryRudesheim >> expressions [
	^ expressions.
]

{ #category : 'initialization' }
ProjectionExpressionTableQueryRudesheim >> setExpressions: aCollection [
	expressions := aCollection.
]
