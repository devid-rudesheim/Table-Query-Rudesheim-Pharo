Extension { #name : 'Array' }

{ #category : '*Rudesheim-Table-Query-Private' }
Array >> asTableQueryProjectionExpressionRudesheim [
	^ Rudesheim TableQuery Expression Projection
		expressions:	self.
]
