Class {
	#name : 'ConstantExpressionTableQueryRudesheim',
	#superclass : 'ExpressionTableQueryRudesheim',
	#instVars : [
		'value'
	],
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'instance creation' }
ConstantExpressionTableQueryRudesheim class >> value: anObject [
	^ self new
		setValue:	anObject.
]

{ #category : 'visiting' }
ConstantExpressionTableQueryRudesheim >> acceptTVisitorRudesheim: aTVisitorRudesheim [
	^ aTVisitorRudesheim
		visitConstantExpressionRudesheim:	self.
]

{ #category : 'initialization' }
ConstantExpressionTableQueryRudesheim >> setValue: anObject [
	value := anObject.
]

{ #category : 'accessing' }
ConstantExpressionTableQueryRudesheim >> value [
	^ value.
]
