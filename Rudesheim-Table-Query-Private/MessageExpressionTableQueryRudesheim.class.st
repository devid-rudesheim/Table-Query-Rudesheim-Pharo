Class {
	#name : 'MessageExpressionTableQueryRudesheim',
	#superclass : 'ExpressionTableQueryRudesheim',
	#instVars : [
		'messageSend'
	],
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'instance creation' }
MessageExpressionTableQueryRudesheim class >> receiver: aReceiverExpressionTableQueryRudesheim
selector: aSymbol
arguments: aCollection [
	^ self new
		setMessageSend:
		(
			MessageSend
				receiver:	aReceiverExpressionTableQueryRudesheim
				selector:	aSymbol
				arguments:	aCollection
		).
]

{ #category : 'visiting' }
MessageExpressionTableQueryRudesheim >> acceptTVisitorRudesheim: aTVisitorRudesheim [
	^ aTVisitorRudesheim
		visitMessageExpressionRudesheim:	self.
]

{ #category : 'accessing' }
MessageExpressionTableQueryRudesheim >> arguments [
	^ messageSend arguments.
]

{ #category : 'accessing' }
MessageExpressionTableQueryRudesheim >> receiver [
	^ messageSend receiver.
]

{ #category : 'accessing' }
MessageExpressionTableQueryRudesheim >> selector [
	^ messageSend selector.
]

{ #category : 'initialization' }
MessageExpressionTableQueryRudesheim >> setMessageSend: aMessageSend [
	messageSend := aMessageSend.
]
