Extension { #name : 'ParameterExpressionTableQueryRudesheim' }

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
ParameterExpressionTableQueryRudesheim >> equalityKeyOperandRudesheim [
	^ self.
]

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
ParameterExpressionTableQueryRudesheim >> fileEqualityWith: anOperand
wholeRow: anOrderedCollection
parameters: aParameterEqualityCollection [
	^ anOperand
		fileEqualityWithParameterOperand:	self
		wholeRow:	anOrderedCollection
		parameters:	aParameterEqualityCollection.
]

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
ParameterExpressionTableQueryRudesheim >> fileEqualityWithParameterOperand: aParameterOperand
wholeRow: anOrderedCollection
parameters: aParameterEqualityCollection [
	self error: 'unsupported predicate'.
]

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
ParameterExpressionTableQueryRudesheim >> fileEqualityWithTableKeyOperand: aTableKeyOperand
wholeRow: anOrderedCollection
parameters: aParameterEqualityCollection [
	aParameterEqualityCollection
		add:
		{
			aTableKeyOperand.
			self
		}.
]

{ #category : '*Rudesheim-Table-Query-InMemory-Private' }
ParameterExpressionTableQueryRudesheim >> keyOperandAppendingSelectorRudesheim: aSymbol [
	self error: 'unsupported predicate'.
]
