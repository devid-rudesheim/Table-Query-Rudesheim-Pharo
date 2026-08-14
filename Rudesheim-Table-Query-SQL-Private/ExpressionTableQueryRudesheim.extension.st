Extension { #name : 'ExpressionTableQueryRudesheim' }

{ #category : '*Rudesheim-Table-Query-SQL-Private' }
ExpressionTableQueryRudesheim >> appendSqlWhereClauseRudesheim: aStream
renderer: aRenderer [
	aStream
		nextPutAll:	' WHERE ';
		nextPutAll:
		(
			aRenderer
				visit:	self
		).
]
