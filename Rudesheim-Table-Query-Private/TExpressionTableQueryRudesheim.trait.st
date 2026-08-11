Trait {
	#name : 'TExpressionTableQueryRudesheim',
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'comparing' }
TExpressionTableQueryRudesheim >> = anObject [
	^ BinaryExpressionTableQueryRudesheim
		receiver:	self
		selector:	#=
		argument:
		(
			self
				wrap:	anObject
		).
]

{ #category : 'proxy' }
TExpressionTableQueryRudesheim >> doesNotUnderstand: aMessage [
	|
		wrappedArguments
	|

	wrappedArguments :=
		aMessage arguments
			collect:
			[ :eachArgument |
				self
					wrap:	eachArgument.
			].

	^
	(
		aMessage
			selector
			isBinary
			and:
			[
				wrappedArguments
					size
					= 1.
			]
	)
		ifTrue:
		[
			BinaryExpressionTableQueryRudesheim
				receiver:	self
				selector:	aMessage selector
				argument:	wrappedArguments first.
		]
		ifFalse:
		[
			MessageExpressionTableQueryRudesheim
				receiver:	self
				selector:	aMessage selector
				arguments:	wrappedArguments.
		].
]

{ #category : 'comparing' }
TExpressionTableQueryRudesheim >> hash [
	^ self identityHash.
]

{ #category : 'testing' }
TExpressionTableQueryRudesheim >> isExpressionRudesheim [
	^ true.
]

{ #category : 'private' }
TExpressionTableQueryRudesheim >> wrap: anObject [
	^ anObject isExpressionRudesheim
		ifTrue:
		[
			anObject.
		]
		ifFalse:
		[
			ConstantExpressionTableQueryRudesheim
				value:	anObject.
		].
]
