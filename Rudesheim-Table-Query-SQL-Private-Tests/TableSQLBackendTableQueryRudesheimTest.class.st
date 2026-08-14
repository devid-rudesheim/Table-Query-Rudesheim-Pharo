Class {
	#name : 'TableSQLBackendTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Table-Query-SQL-Private-Tests-Table',
	#package : 'Rudesheim-Table-Query-SQL-Private-Tests',
	#tag : 'Table'
}

{ #category : 'accessing' }
TableSQLBackendTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim
		TableQuery
		Backend
		SQL
		Table.
]

{ #category : 'accessing' }
TableSQLBackendTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		name:	#numbers.
]

{ #category : 'tests' }
TableSQLBackendTableQueryRudesheimTest >> testName [
	self
		assert:	self basicTarget name
		equals:	#numbers.
]
