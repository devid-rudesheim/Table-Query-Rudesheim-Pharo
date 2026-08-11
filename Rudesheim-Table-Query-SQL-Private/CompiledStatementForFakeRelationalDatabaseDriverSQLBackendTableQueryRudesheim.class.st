"
A tiny holder record returned by FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim>>compileSelectFrom:where:select:. It packages the three arguments verbatim; no real compilation happens (this driver is verification-only).
"
Class {
	#name : 'CompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim',
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
CompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim class >> tables: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	^ self new
		setTables:	aCollectionOfTables
		where:	aWhereExpressionTableQueryRudesheim
		select:	aSelectExpressionTableQueryRudesheim.
]

{ #category : 'accessing' }
CompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> selectExpression [
	^ selectExpression.
]

{ #category : 'initialization' }
CompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> setTables: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	tables := aCollectionOfTables.
	whereExpression := aWhereExpressionTableQueryRudesheim.
	selectExpression := aSelectExpressionTableQueryRudesheim.
]

{ #category : 'accessing' }
CompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> tables [
	^ tables.
]

{ #category : 'accessing' }
CompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> whereExpression [
	^ whereExpression.
]
