Class {
	#name : 'SQLBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TBackendTableQueryRudesheim + TShouldntNewRudesheim',
	#classTraits : 'TBackendTableQueryRudesheim classTrait + TShouldntNewRudesheim classTrait',
	#instVars : [
		'driver'
	],
	#category : 'Rudesheim-Table-Query-SQL-Backend',
	#package : 'Rudesheim-Table-Query-SQL',
	#tag : 'Backend'
}

{ #category : 'namespace' }
SQLBackendTableQueryRudesheim class >> CompiledStatementForFakeRelationalDatabaseDriver [
	^ CompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
SQLBackendTableQueryRudesheim class >> FakeRelationalDatabaseDriver [
	^ FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
SQLBackendTableQueryRudesheim class >> PreparedQuery [
	^ PreparedQuerySQLBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
SQLBackendTableQueryRudesheim class >> SQLStringForExpression [
	^ SQLStringForExpressionSQLBackendTableQueryRudesheim.
]

{ #category : 'namespace' }
SQLBackendTableQueryRudesheim class >> Table [
	^ TableSQLBackendTableQueryRudesheim.
]

{ #category : 'instance creation' }
SQLBackendTableQueryRudesheim class >> driver: aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim [
	^ super new
		setDriver:	aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim.
]

{ #category : 'evaluating' }
SQLBackendTableQueryRudesheim >> inquireTableQuery: aBlockClosure
from: aCollection [
	^
	(
		self
			prepareTableQuery:	aBlockClosure
			from:	aCollection
	)
		valueWithArguments:	#().
]

{ #category : 'preparing' }
SQLBackendTableQueryRudesheim >> prepareTableQuery: aBlockClosure
from: aCollection [
	|
		statement
		rows
		parameters
		compiledStatement
	|

	statement := ExpressionCapturingStatementTableQueryRudesheim new.

	rows :=
		(
			1
				to:	aCollection size
		)
			collect:
			[ :eachTableIndex |
				FieldExpressionTableQueryRudesheim
					table:	eachTableIndex.
			].

	parameters := ParameterCaptureTableQueryRudesheim new.

	aBlockClosure
		cull:	statement
		cull:	rows asArray
		cull:	parameters.

	compiledStatement :=
		driver
			compileSelectFrom:	aCollection
			where:	statement whereExpression
			select:	statement selectExpression.

	^ PreparedQuerySQLBackendTableQueryRudesheim
		driver:	driver
		compiledStatement:	compiledStatement.
]

{ #category : 'initialization' }
SQLBackendTableQueryRudesheim >> setDriver: aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim [
	driver := aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim.
]
