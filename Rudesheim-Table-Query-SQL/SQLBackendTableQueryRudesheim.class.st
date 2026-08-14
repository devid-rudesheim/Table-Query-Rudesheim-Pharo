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
SQLBackendTableQueryRudesheim class >> Driver [

	^ DriverSQLBackendTableQueryRudesheim.
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
		tableQuery
	|

	tableQuery := Rudesheim TableQuery.

	statement := tableQuery ExpressionCapturingStatement new.

	rows :=
		self class
			rowPlaceholdersFor:	aCollection.

	parameters := tableQuery ParameterCapture new.

	aBlockClosure
		cull:	statement
		cull:	rows asArray
		cull:	parameters.

	compiledStatement :=
		driver
			compileSelectFrom:	aCollection
			where:	statement whereExpression
			select:	statement selectExpression.

	^ tableQuery Backend SQL PreparedQuery
		driver:	driver
		compiledStatement:	compiledStatement.
]

{ #category : 'initialization' }
SQLBackendTableQueryRudesheim >> setDriver: aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim [
	driver := aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim.
]
