"
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim executes SQLBackendTableQueryRudesheim compiled select statements through a Pharo-SQLite3 connection.
"
Class {
	#name : 'SQLite3DriverSQLBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TRelationalDatabaseDriverSQLBackendTableQueryRudesheim + TShouldntNewUtilityRudesheim',
	#classTraits : 'TRelationalDatabaseDriverSQLBackendTableQueryRudesheim classTrait + TShouldntNewUtilityRudesheim classTrait',
	#instVars : [
		'connection'
	],
	#category : 'Rudesheim-Table-Query-SQL-SQLite3-Driver',
	#package : 'Rudesheim-Table-Query-SQL-SQLite3',
	#tag : 'Driver'
}

{ #category : 'namespace' }
SQLite3DriverSQLBackendTableQueryRudesheim class >> CompiledStatement [
	^ CompiledStatementSQLite3DriverSQLBackendTableQueryRudesheim.
]

{ #category : 'instance creation' }
SQLite3DriverSQLBackendTableQueryRudesheim class >> connection: anObject [
	^ super new
		setConnection:	anObject.
]

{ #category : 'compiling' }
SQLite3DriverSQLBackendTableQueryRudesheim >> compileSelectFrom: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	^ self class CompiledStatement
		tables:	aCollectionOfTables
		where:	aWhereExpressionTableQueryRudesheim
		select:	aSelectExpressionTableQueryRudesheim
		sqlString:
		(
			self
				sqlStringForTables:	aCollectionOfTables
				where:	aWhereExpressionTableQueryRudesheim
				select:	aSelectExpressionTableQueryRudesheim
		).
]

{ #category : 'evaluating' }
SQLite3DriverSQLBackendTableQueryRudesheim >> execute: aCompiledStatement
with: aCollectionOfParameterValues [
	|
		cursor
	|

	cursor :=
		connection
			execute:	aCompiledStatement sqlString
			with:	aCollectionOfParameterValues asArray.

	^ cursor rows
		collect:
		[ :eachRow |
			self
				resultForRow:	eachRow
				compiledStatement:	aCompiledStatement.
		].
]

{ #category : 'private' }
SQLite3DriverSQLBackendTableQueryRudesheim >> resultForRow: aSQLite3Row
compiledStatement: aCompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim [
	^ aCompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim selectExpression
		shapeResultRudesheim:	aSQLite3Row asArray.
]

{ #category : 'initialization' }
SQLite3DriverSQLBackendTableQueryRudesheim >> setConnection: anObject [
	connection := anObject.
]

{ #category : 'printing' }
SQLite3DriverSQLBackendTableQueryRudesheim >> sqlStringFor: aCompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim [
	^ aCompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim
		sqlString.
]

{ #category : 'private' }
SQLite3DriverSQLBackendTableQueryRudesheim >> sqlStringForTables: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	|
		expressionRenderer
	|

	expressionRenderer :=
		SQLStringForExpressionSQLBackendTableQueryRudesheim
			tables:	aCollectionOfTables.

	^ String
		streamContents:
		[ :aStream |
			aStream
				nextPutAll:	'SELECT ';
				nextPutAll:
				(
					expressionRenderer
						visit:	aSelectExpressionTableQueryRudesheim
				);
				nextPutAll:	' FROM ';
				nextPutAll:
				(
					self
						tablesSqlStringFor:	aCollectionOfTables
				).

			aWhereExpressionTableQueryRudesheim
				appendSqlWhereClauseRudesheim:	aStream
				renderer:	expressionRenderer.
		].
]

{ #category : 'private' }
SQLite3DriverSQLBackendTableQueryRudesheim >> tablesSqlStringFor: aCollectionOfTables [
	^ String
		streamContents:
		[ :aStream |
			1
				to:	aCollectionOfTables size
				do:
				[ :eachTableIndex |
					eachTableIndex > 1
						ifTrue:
						[
							aStream
								nextPutAll:	', '.
						].

					aStream
						nextPutAll:
						(
							aCollectionOfTables
								at:	eachTableIndex
						)
							name
							asString;
						nextPutAll:	' t';
						nextPutAll:	eachTableIndex asString.
				].
		].
]
