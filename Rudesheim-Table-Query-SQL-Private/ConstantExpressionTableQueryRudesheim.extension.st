Extension { #name : 'ConstantExpressionTableQueryRudesheim' }

{ #category : '*Rudesheim-Table-Query-SQL-Private' }
ConstantExpressionTableQueryRudesheim >> appendSqlWhereClauseRudesheim: aStream
renderer: aRenderer [
	self value
		ifTrue: [ ^ self ].

	super
		appendSqlWhereClauseRudesheim:	aStream
		renderer:	aRenderer.
]
