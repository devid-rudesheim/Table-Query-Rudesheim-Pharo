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
			self
				wrap:	anObject
		).
]

{ #category : 'proxy' }
TExpressionTableQueryRudesheim >> doesNotUnderstand: aMessage [
	|
		wrappedArguments
		expression
	|
	
	expression := Rudesheim TableQuery Expression.

	wrappedArguments :=
		aMessage arguments
			collect:
			[ :eachArgument |
				self
					wrap:	eachArgument.
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
			Rudesheim TableQuery Expression Constant
				value:	anObject.
		].
]
