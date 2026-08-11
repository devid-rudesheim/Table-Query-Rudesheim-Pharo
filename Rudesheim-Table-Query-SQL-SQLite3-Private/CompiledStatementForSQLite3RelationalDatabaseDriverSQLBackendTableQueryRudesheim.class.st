"
CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim stores the SQL text and select shape used by SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim.
"
Class {
	#name : 'CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim',
	#superclass : 'Object',
	#instVars : [
		'tables',
		'whereExpression',
		'selectExpression',
		'sqlString'
	],
	#category : 'Rudesheim-Table-Query-SQL-SQLite3-Private-Driver',
	#package : 'Rudesheim-Table-Query-SQL-SQLite3-Private',
	#tag : 'Driver'
}

{ #category : 'instance creation' }
CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim class >> tables: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim
sqlString: aString [
	^ self new
		setTables:	aCollectionOfTables
		where:	aWhereExpressionTableQueryRudesheim
		select:	aSelectExpressionTableQueryRudesheim
		sqlString:	aString.
]

{ #category : 'testing' }
CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> returnsProjection [
	^ selectExpression
		class
		== ProjectionExpressionTableQueryRudesheim.
]

{ #category : 'accessing' }
CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> selectExpression [
	^ selectExpression.
]

{ #category : 'initialization' }
CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> setTables: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim
sqlString: aString [
	tables := aCollectionOfTables.
	whereExpression := aWhereExpressionTableQueryRudesheim.
	selectExpression := aSelectExpressionTableQueryRudesheim.
	sqlString := aString.
]

{ #category : 'accessing' }
CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> sqlString [
	^ sqlString.
]

{ #category : 'accessing' }
CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> tables [
	^ tables.
]

{ #category : 'accessing' }
CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> whereExpression [
	^ whereExpression.
]
