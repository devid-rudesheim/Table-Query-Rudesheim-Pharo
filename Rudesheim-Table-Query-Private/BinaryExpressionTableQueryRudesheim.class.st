Class {
	#name : 'BinaryExpressionTableQueryRudesheim',
	#superclass : 'ExpressionTableQueryRudesheim',
	#instVars : [
		'receiver',
		'selector',
		'argument'
	],
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'instance creation' }
BinaryExpressionTableQueryRudesheim class >> receiver: aReceiverExpressionTableQueryRudesheim
selector: aSymbol
argument: anArgumentExpressionTableQueryRudesheim [
	^ self new
		setReceiver:	aReceiverExpressionTableQueryRudesheim
		selector:	aSymbol
		argument:	anArgumentExpressionTableQueryRudesheim.
]

{ #category : 'instance creation' }
BinaryExpressionTableQueryRudesheim class >> receiver: aReceiverExpressionTableQueryRudesheim
selector: aSymbol
arguments: anArgumentExpressionTableQueryRudesheim [
	^ self
		receiver:	aReceiverExpressionTableQueryRudesheim
		selector:	aSymbol
		argument:	anArgumentExpressionTableQueryRudesheim first.
]

{ #category : 'visiting' }
BinaryExpressionTableQueryRudesheim >> acceptTVisitorRudesheim: aTVisitorRudesheim [
	^ aTVisitorRudesheim
		visitBinaryExpressionRudesheim:	self.
]

{ #category : 'accessing' }
BinaryExpressionTableQueryRudesheim >> argument [
	^ argument.
]

{ #category : 'accessing' }
BinaryExpressionTableQueryRudesheim >> receiver [
	^ receiver.
]

{ #category : 'accessing' }
BinaryExpressionTableQueryRudesheim >> selector [
	^ selector.
]

{ #category : 'initialization' }
BinaryExpressionTableQueryRudesheim >> setReceiver: aReceiverExpressionTableQueryRudesheim
selector: aSymbol
argument: anArgumentExpressionTableQueryRudesheim [
	receiver := aReceiverExpressionTableQueryRudesheim.
	selector := aSymbol.
	argument := anArgumentExpressionTableQueryRudesheim.
]
