Extension { #name : 'MessageExpressionTableQueryRudesheim' }

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
MessageExpressionTableQueryRudesheim >> equalityKeyOperandRudesheim [
	self selector isUnary
		ifFalse: [ ^ self error: 'unsupported predicate' ].

	self arguments isEmpty
		ifFalse: [ ^ self error: 'unsupported predicate' ].

	^ self receiver equalityKeyOperandRudesheim
		keyOperandAppendingSelectorRudesheim:	self selector.
]
