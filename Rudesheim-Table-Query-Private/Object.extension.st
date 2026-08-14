Extension { #name : 'Object' }

{ #category : '*Rudesheim-Table-Query-Private' }
Object >> asTableQueryExpressionRudesheim [
	^ Rudesheim TableQuery Expression Constant
		value:	self.
]

{ #category : '*Rudesheim-Table-Query-Private' }
Object >> asTableQueryProjectionExpressionRudesheim [
	^ self.
]
