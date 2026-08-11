Extension { #name : 'Array' }

{ #category : '*Rudesheim-Table-Query-Private' }
Array >> asTableQueryProjectionExpressionRudesheim [
	^ ProjectionExpressionTableQueryRudesheim
		expressions:	self.
]
