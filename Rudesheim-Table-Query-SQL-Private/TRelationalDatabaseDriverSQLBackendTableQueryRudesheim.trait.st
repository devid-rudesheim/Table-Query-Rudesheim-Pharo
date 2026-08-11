Trait {
	#name : 'TRelationalDatabaseDriverSQLBackendTableQueryRudesheim',
	#category : 'Rudesheim-Table-Query-SQL-Private-Driver',
	#package : 'Rudesheim-Table-Query-SQL-Private',
	#tag : 'Driver'
}

{ #category : 'compiling' }
TRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> compileSelectFrom: aCollection
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	^ self subclassResponsibility.
]

{ #category : 'evaluating' }
TRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> execute: aCompiledStatement
with: aCollectionOfParameterValues [
	^ self subclassResponsibility.
]

{ #category : 'printing' }
TRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> sqlStringFor: anObject [
	^ self subclassResponsibility.
]
