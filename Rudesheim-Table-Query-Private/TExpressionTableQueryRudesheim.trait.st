Trait {
	#name : 'TExpressionTableQueryRudesheim',
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'comparing' }
TExpressionTableQueryRudesheim >> = anObject [
	^ Rudesheim TableQuery Expression Binary
		receiver:	self
		selector:	#=
		argument:
		(
			anObject
				peekDelegateRudesheim
				asTableQueryExpressionRudesheim
		).
]

{ #category : 'converting' }
TExpressionTableQueryRudesheim >> asTableQueryExpressionRudesheim [
	^ self.
]

{ #category : 'proxy' }
TExpressionTableQueryRudesheim >> doesNotUnderstand: aMessage [
	^ self
		processMessage:	aMessage.
]

{ #category : 'comparing' }
TExpressionTableQueryRudesheim >> hash [
	^ self identityHash.
]

{ #category : 'proxy' }
TExpressionTableQueryRudesheim >> processMessage: aMessage [
	|
		wrappedArguments
		expression
	|

	expression := Rudesheim TableQuery Expression.

	wrappedArguments :=
		aMessage arguments
			collect:
			[ :eachArgument |
				eachArgument
					peekDelegateRudesheim
					asTableQueryExpressionRudesheim.
			].

	^
	(
		(
			aMessage	selector isBinary
				and:
				[
					1 = wrappedArguments size.
				]
		)
			ifTrue:
			[
				expression Binary
			]
			ifFalse:
			[
				expression Message
			]
	)
		receiver:		self
		selector:		aMessage selector
		arguments:	wrappedArguments.

]
