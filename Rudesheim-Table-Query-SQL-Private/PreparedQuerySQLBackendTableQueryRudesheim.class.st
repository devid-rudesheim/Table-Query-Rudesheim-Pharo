Class {
	#name : 'PreparedQuerySQLBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TCallableUtilityRudesheim + TShouldntNewUtilityRudesheim',
	#classTraits : 'TCallableUtilityRudesheim classTrait + TShouldntNewUtilityRudesheim classTrait',
	#instVars : [
		'driver',
		'compiledStatement'
	],
	#category : 'Rudesheim-Table-Query-SQL-Private-Query',
	#package : 'Rudesheim-Table-Query-SQL-Private',
	#tag : 'Query'
}

{ #category : 'instance creation' }
PreparedQuerySQLBackendTableQueryRudesheim class >> driver: aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim
compiledStatement: anObject [
	^ super new
		setDriver:	aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim
		compiledStatement:	anObject.
]

{ #category : 'initialization' }
PreparedQuerySQLBackendTableQueryRudesheim >> setDriver: aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim
compiledStatement: anObject [
	driver := aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim.
	compiledStatement := anObject.
]

{ #category : 'printing' }
PreparedQuerySQLBackendTableQueryRudesheim >> sqlString [
	^ driver
		sqlStringFor:	compiledStatement.
]

{ #category : 'evaluating' }
PreparedQuerySQLBackendTableQueryRudesheim >> valueWithArguments: aCollection [
	^ driver
		execute:	compiledStatement
		with:	aCollection.
]
