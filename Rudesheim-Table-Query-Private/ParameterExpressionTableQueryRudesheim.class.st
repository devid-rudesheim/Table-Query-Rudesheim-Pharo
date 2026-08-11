Class {
	#name : 'ParameterExpressionTableQueryRudesheim',
	#superclass : 'ExpressionTableQueryRudesheim',
	#instVars : [
		'index'
	],
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'instance creation' }
ParameterExpressionTableQueryRudesheim class >> index: anInteger [
	^ self new
		setIndex:	anInteger.
]

{ #category : 'visiting' }
ParameterExpressionTableQueryRudesheim >> acceptTVisitorRudesheim: aTVisitorRudesheim [
	^ aTVisitorRudesheim
		visitParameterExpressionRudesheim:	self.
]

{ #category : 'accessing' }
ParameterExpressionTableQueryRudesheim >> index [
	^ index.
]

{ #category : 'initialization' }
ParameterExpressionTableQueryRudesheim >> setIndex: anInteger [
	index := anInteger.
]
