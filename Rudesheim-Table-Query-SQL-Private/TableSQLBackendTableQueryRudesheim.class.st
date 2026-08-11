"
A TableSQLBackendTableQueryRudesheim identifies a table by name for a SQL-style query backend to resolve (see FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim>>execute:with:). Currently a bare name holder; expected to grow column-introspection behavior later.
"
Class {
	#name : 'TableSQLBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TTableSQLBackendTableQueryRudesheim + TShouldntNewRudesheim',
	#classTraits : 'TTableSQLBackendTableQueryRudesheim classTrait + TShouldntNewRudesheim classTrait',
	#instVars : [
		'name'
	],
	#category : 'Rudesheim-Table-Query-SQL-Private-Table',
	#package : 'Rudesheim-Table-Query-SQL-Private',
	#tag : 'Table'
}

{ #category : 'instance creation' }
TableSQLBackendTableQueryRudesheim class >> name: aSymbol [
	^ super new
		setName:	aSymbol.
]

{ #category : 'accessing' }
TableSQLBackendTableQueryRudesheim >> name [
	^ name.
]

{ #category : 'initialization' }
TableSQLBackendTableQueryRudesheim >> setName: aSymbol [
	name := aSymbol.
]
