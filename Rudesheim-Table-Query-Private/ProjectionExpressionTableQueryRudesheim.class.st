Class {
	#name : 'ProjectionExpressionTableQueryRudesheim',
	#superclass : 'ExpressionTableQueryRudesheim',
	#traits : 'TShouldntNewRudesheim',
	#classTraits : 'TShouldntNewRudesheim classTrait',
	#instVars : [
		'expressions'
	],
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'instance creation' }
ProjectionExpressionTableQueryRudesheim class >> expressions: aCollection [
	^ super new
		setExpressions:	aCollection.
]

{ #category : 'converting' }
ProjectionExpressionTableQueryRudesheim class >> shapeResultRudesheim: aRowValueCollection [
	^ aRowValueCollection.
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
