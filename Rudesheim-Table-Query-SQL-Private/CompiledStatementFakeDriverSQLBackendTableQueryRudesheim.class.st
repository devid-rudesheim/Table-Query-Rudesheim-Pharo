"
A tiny holder record returned by FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim>>compileSelectFrom:where:select:. It packages the three arguments verbatim; no real compilation happens (this driver is verification-only).
"
Class {
	#name : 'CompiledStatementFakeDriverSQLBackendTableQueryRudesheim',
	#superclass : 'Object',
	#instVars : [
		'tables',
		'whereExpression',
		'selectExpression'
	],
	#category : 'Rudesheim-Table-Query-SQL-Private-Driver',
	#package : 'Rudesheim-Table-Query-SQL-Private',
	#tag : 'Driver'
}

{ #category : 'instance creation' }
CompiledStatementFakeDriverSQLBackendTableQueryRudesheim class >> tables: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	^ self new
		setTables:	aCollectionOfTables
		where:	aWhereExpressionTableQueryRudesheim
		select:	aSelectExpressionTableQueryRudesheim.
]

{ #category : 'accessing' }
CompiledStatementFakeDriverSQLBackendTableQueryRudesheim >> selectExpression [
	^ selectExpression.
]

{ #category : 'initialization' }
CompiledStatementFakeDriverSQLBackendTableQueryRudesheim >> setTables: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	tables := aCollectionOfTables.
	whereExpression := aWhereExpressionTableQueryRudesheim.
	selectExpression := aSelectExpressionTableQueryRudesheim.
]

{ #category : 'accessing' }
CompiledStatementFakeDriverSQLBackendTableQueryRudesheim >> tables [
	^ tables.
]

{ #category : 'accessing' }
CompiledStatementFakeDriverSQLBackendTableQueryRudesheim >> whereExpression [
	^ whereExpression.
]
