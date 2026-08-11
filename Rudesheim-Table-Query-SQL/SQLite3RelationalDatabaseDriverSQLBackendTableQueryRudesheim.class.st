"
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim executes SQLBackendTableQueryRudesheim compiled select statements through a Pharo-SQLite3 connection.
"
Class {
	#name : 'SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TRelationalDatabaseDriverSQLBackendTableQueryRudesheim + TShouldntNewRudesheim',
	#classTraits : 'TRelationalDatabaseDriverSQLBackendTableQueryRudesheim classTrait + TShouldntNewRudesheim classTrait',
	#instVars : [
		'connection'
	],
	#category : 'Rudesheim-Table-Query-SQL-Driver',
	#package : 'Rudesheim-Table-Query-SQL',
	#tag : 'Driver'
}

{ #category : 'namespace' }
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim class >> CompiledStatement [
	^ CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim.
]

{ #category : 'instance creation' }
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim class >> connection: anObject [
	^ super new
		setConnection:	anObject.
]

{ #category : 'compiling' }
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> compileSelectFrom: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	^ CompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim
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
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> execute: aCompiledStatement
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
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> resultForRow: aSQLite3Row
compiledStatement: aCompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim [
	|
		rowValues
	|

	rowValues := aSQLite3Row asArray.

	^ aCompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim returnsProjection
		ifTrue:
		[
			rowValues.
		]
		ifFalse:
		[
			rowValues first.
		].
]

{ #category : 'initialization' }
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> setConnection: anObject [
	connection := anObject.
]

{ #category : 'private' }
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> shouldOmitWhereClauseFor: anExpressionTableQueryRudesheim [
	^ anExpressionTableQueryRudesheim
		class
		== ConstantExpressionTableQueryRudesheim
		and:
		[
			anExpressionTableQueryRudesheim
				value
				== true.
		].
]

{ #category : 'printing' }
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> sqlStringFor: aCompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim [
	^ aCompiledStatementForSQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim
		sqlString.
]

{ #category : 'private' }
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> sqlStringForTables: aCollectionOfTables
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

			(
				self
					shouldOmitWhereClauseFor:	aWhereExpressionTableQueryRudesheim
			)
				ifFalse:
				[
					aStream
						nextPutAll:	' WHERE ';
						nextPutAll:
						(
							expressionRenderer
								visit:	aWhereExpressionTableQueryRudesheim
						).
				].
		].
]

{ #category : 'private' }
SQLite3RelationalDatabaseDriverSQLBackendTableQueryRudesheim >> tablesSqlStringFor: aCollectionOfTables [
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
