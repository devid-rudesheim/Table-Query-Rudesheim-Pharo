"
CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim stores the SQL text and select shape used by SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim.
"
Class {
	#name : 'CompiledStatementSQLite3DriverSQLBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewRudesheim',
	#classTraits : 'TShouldntNewRudesheim classTrait',
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
CompiledStatementSQLite3DriverSQLBackendTableQueryRudesheim class >> tables: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim
sqlString: aString [
	^ super new
		setTables:	aCollectionOfTables
		where:	aWhereExpressionTableQueryRudesheim
		select:	aSelectExpressionTableQueryRudesheim
		sqlString:	aString.
]

{ #category : 'accessing' }
CompiledStatementSQLite3DriverSQLBackendTableQueryRudesheim >> selectExpression [
	^ selectExpression.
]

{ #category : 'initialization' }
CompiledStatementSQLite3DriverSQLBackendTableQueryRudesheim >> setTables: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim
sqlString: aString [
	tables := aCollectionOfTables.
	whereExpression := aWhereExpressionTableQueryRudesheim.
	selectExpression := aSelectExpressionTableQueryRudesheim.
	sqlString := aString.
]

{ #category : 'accessing' }
CompiledStatementSQLite3DriverSQLBackendTableQueryRudesheim >> sqlString [
	^ sqlString.
]

{ #category : 'accessing' }
CompiledStatementSQLite3DriverSQLBackendTableQueryRudesheim >> tables [
	^ tables.
]

{ #category : 'accessing' }
CompiledStatementSQLite3DriverSQLBackendTableQueryRudesheim >> whereExpression [
	^ whereExpression.
]
