Extension { #name : 'FieldExpressionTableQueryRudesheim' }

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
FieldExpressionTableQueryRudesheim >> equalityKeyOperandRudesheim [
	^ Rudesheim TableQuery Backend InMemory TableKeyOperand
		tableIndex:	self tableIndex
		keyAccessorPath:	self keyAccessorPathRudesheim.
]

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
FieldExpressionTableQueryRudesheim >> keyAccessorPathRudesheim [
	^ self fieldSelector
		ifNil:	[ #() ]
		ifNotNil:	[ :aFieldSelector | Array with: aFieldSelector ].
]
