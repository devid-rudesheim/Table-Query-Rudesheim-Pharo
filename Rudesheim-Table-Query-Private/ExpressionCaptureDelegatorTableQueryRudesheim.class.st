"
An ExpressionCaptureDelegatorTableQueryRudesheim wraps a captured ExpressionTableQueryRudesheim node so that a capture block can keep sending it arbitrary messages (including ones Object already implements, like #=) and have them captured as new AST nodes via TExpressionTableQueryRudesheim>>processMessage:. Every result handed back across the wrapper boundary is re-wrapped (see #forwardedResultRudesheim:) so continued chaining stays captured; internal collaborators (visitor, evaluator, optimizer, SQL renderer) only ever see the real, unwrapped node — see ExpressionCapturingStatementTableQueryRudesheim, which unwraps via #peekDelegateRudesheim before storing the captured tree.
"
Class {
	#name : 'ExpressionCaptureDelegatorTableQueryRudesheim',
	#superclass : 'MessageForwardingDelegatorRudesheim',
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'options' }
ExpressionCaptureDelegatorTableQueryRudesheim >> forwardedResultRudesheim: anObject [

	^ self class
		delegateTo:	anObject.
]
