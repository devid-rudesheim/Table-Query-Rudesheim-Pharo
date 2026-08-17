Class {
	#name : 'ParameterExpressionTableQueryRudesheim',
	#superclass : 'ExpressionTableQueryRudesheim',
	#traits : 'TShouldntNewRudesheim',
	#classTraits : 'TShouldntNewRudesheim classTrait',
	#instVars : [
		'index'
	],
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'instance creation' }
ParameterExpressionTableQueryRudesheim class >> index: anInteger [
	^ super new
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
