"
TTableSQLBackendTableQueryRudesheim is the interface a table reference object must implement to be usable in #prepareTableQuery:from:/#inquireTableQuery:from:'s `from:` collection with a SQL-style backend. Currently only a name (used by drivers to resolve the real table); expected to grow column-introspection behavior later.
"
Trait {
	#name : 'TTableSQLBackendTableQueryRudesheim',
	#category : 'Rudesheim-Table-Query-SQL-Private-Table',
	#package : 'Rudesheim-Table-Query-SQL-Private',
	#tag : 'Table'
}

{ #category : 'accessing' }
TTableSQLBackendTableQueryRudesheim >> name [
	^ self subclassResponsibility.
]
