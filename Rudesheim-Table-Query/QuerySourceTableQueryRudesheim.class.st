Class {
	#name : 'QuerySourceTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewRudesheim',
	#classTraits : 'TShouldntNewRudesheim classTrait',
	#instVars : [
		'sourceCollections'
	],
	#category : 'Rudesheim-Table-Query-Query',
	#package : 'Rudesheim-Table-Query',
	#tag : 'Query'
}

{ #category : 'instance creation' }
QuerySourceTableQueryRudesheim class >> fromCollections: aCollection [

	^ super new
		setCollections:	aCollection.
]

{ #category : 'converting' }
QuerySourceTableQueryRudesheim >> asInMemory [
	|
		tableQuery
	|
	
	tableQuery := Rudesheim	TableQuery.

	^ tableQuery Query
		fromCollections:	sourceCollections
		backend:	tableQuery Backend InMemory.
]

{ #category : 'converting' }
QuerySourceTableQueryRudesheim >> asInSQLUsing: aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim [

	^ Rudesheim
		TableQuery
		Query
		fromCollections:	sourceCollections
		backend:
		(
			Rudesheim
				TableQuery
				Backend
				SQL
				driver:	aTRelationalDatabaseDriverSQLBackendTableQueryRudesheim
		).
]

{ #category : 'initialization' }
QuerySourceTableQueryRudesheim >> setCollections: aCollection [

	sourceCollections := aCollection.
	^ self.
]
