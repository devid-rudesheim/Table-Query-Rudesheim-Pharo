"
A TableKeyOperandInMemoryBackendTableQueryRudesheim identifies a table (by tableIndex) and, optionally, a field path within its rows (keyAccessorPath) as one side of an equality predicate the EqualityIntersectionPlanInMemoryBackendTableQueryRudesheim optimizer can use as a join/lookup key. Built by ExpressionTableQueryRudesheim subclasses (see FieldExpressionTableQueryRudesheim/MessageExpressionTableQueryRudesheim>>equalityKeyOperandRudesheim). Files itself against the other side of an equality (another TableKeyOperandInMemoryBackendTableQueryRudesheim, or a ParameterExpressionTableQueryRudesheim) via double dispatch (#fileEqualityWith:wholeRow:parameters:) instead of an external class check.
"
Class {
	#name : 'TableKeyOperandInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#instVars : [
		'tableIndex',
		'keyAccessorPath'
	],
	#category : 'Rudesheim-Table-Query-InMemory-Private-Optimization',
	#package : 'Rudesheim-Table-Query-InMemory-Private',
	#tag : 'Optimization'
}

{ #category : 'instance creation' }
TableKeyOperandInMemoryBackendTableQueryRudesheim class >> tableIndex: anInteger
keyAccessorPath: aCollection [
	^ self new
		setTableIndex:	anInteger
		keyAccessorPath:	aCollection.
]

{ #category : 'filing' }
TableKeyOperandInMemoryBackendTableQueryRudesheim >> fileEqualityWith: anOperand
wholeRow: anOrderedCollection
parameters: aParameterEqualityCollection [
	^ anOperand
		fileEqualityWithTableKeyOperand:	self
		wholeRow:	anOrderedCollection
		parameters:	aParameterEqualityCollection.
]

{ #category : 'filing' }
TableKeyOperandInMemoryBackendTableQueryRudesheim >> fileEqualityWithParameterOperand: aParameterOperand
wholeRow: anOrderedCollection
parameters: aParameterEqualityCollection [
	aParameterEqualityCollection
		add:
		{
			self.
			aParameterOperand
		}.
]

{ #category : 'filing' }
TableKeyOperandInMemoryBackendTableQueryRudesheim >> fileEqualityWithTableKeyOperand: aTableKeyOperand
wholeRow: anOrderedCollection
parameters: aParameterEqualityCollection [
	anOrderedCollection
		add:
		{
			aTableKeyOperand.
			self
		}.
]

{ #category : 'accessing' }
TableKeyOperandInMemoryBackendTableQueryRudesheim >> keyAccessorPath [
	^ keyAccessorPath.
]

{ #category : 'converting' }
TableKeyOperandInMemoryBackendTableQueryRudesheim >> keyOperandAppendingSelectorRudesheim: aSymbol [
	^ self class
		tableIndex:	self tableIndex
		keyAccessorPath:
		(
			self keyAccessorPath
				copyWith:	aSymbol
		).
]

{ #category : 'initialization' }
TableKeyOperandInMemoryBackendTableQueryRudesheim >> setTableIndex: anInteger
keyAccessorPath: aCollection [
	tableIndex := anInteger.
	keyAccessorPath := aCollection.
]

{ #category : 'accessing' }
TableKeyOperandInMemoryBackendTableQueryRudesheim >> tableIndex [
	^ tableIndex.
]
