"
SQLStringForExpressionSQLBackendTableQueryRudesheim renders a captured table-query expression tree as a SQL expression fragment for FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim.
"
Class {
	#name : 'SQLStringForExpressionSQLBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TVisitorRudesheim + TShouldntNewRudesheim',
	#classTraits : 'TVisitorRudesheim classTrait + TShouldntNewRudesheim classTrait',
	#instVars : [
		'tables'
	],
	#category : 'Rudesheim-Table-Query-SQL-Private-Rendering',
	#package : 'Rudesheim-Table-Query-SQL-Private',
	#tag : 'Rendering'
}

{ #category : 'instance creation' }
SQLStringForExpressionSQLBackendTableQueryRudesheim class >> tables: aCollection [
	^ super new
		setTables:	aCollection.
]

{ #category : 'private' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> projectionSqlStringFor: aCollection [
	^ String
		streamContents:
		[ :aStream |
			1
				to:	aCollection size
				do:
				[ :eachExpressionIndex |
					eachExpressionIndex > 1
						ifTrue:
						[
							aStream
								nextPutAll:	', '.
						].

					aStream
						nextPutAll:
						(
							self
								visit:
								(
									aCollection
										at:	eachExpressionIndex
								)
						).
				].
		].
]

{ #category : 'initialization' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> setTables: aCollection [
	tables := aCollection.
]

{ #category : 'private' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> sqlStringForBinarySelector: aSymbol [
	aSymbol = #&
		ifTrue:
		[
			^ 'AND'.
		].

	aSymbol = #|
		ifTrue:
		[
			^ 'OR'.
		].

	^ aSymbol asString.
]

{ #category : 'private' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> sqlStringForConstantValue: anObject [
	anObject isString
		ifTrue:
		[
			^ ''''
				, anObject
				, ''''.
		].

	anObject == true
		ifTrue:
		[
			^ 'TRUE'.
		].

	anObject == false
		ifTrue:
		[
			^ 'FALSE'.
		].

	^ anObject asString.
]

{ #category : 'private' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> tableAliasForIndex: anInteger [
	^ 't' , anInteger asString.
]

{ #category : 'visiting' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> visitBinaryExpressionRudesheim: aBinaryExpressionTableQueryRudesheim [
	^ '('
		, (self visit: aBinaryExpressionTableQueryRudesheim receiver)
		, ' '
		, (self sqlStringForBinarySelector: aBinaryExpressionTableQueryRudesheim selector)
		, ' '
		, (self visit: aBinaryExpressionTableQueryRudesheim argument)
		, ')'.
]

{ #category : 'visiting' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> visitConstantExpressionRudesheim: aConstantExpressionTableQueryRudesheim [
	^ self
		sqlStringForConstantValue:	aConstantExpressionTableQueryRudesheim value.
]

{ #category : 'visiting' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> visitFieldExpressionRudesheim: aFieldExpressionTableQueryRudesheim [
	|
		alias
	|

	alias :=
		self
			tableAliasForIndex:	aFieldExpressionTableQueryRudesheim tableIndex.

	^ aFieldExpressionTableQueryRudesheim fieldSelector
		ifNil:
		[
			alias.
		]
		ifNotNil:
		[ :aSymbol |
			alias
				, '.'
				, aSymbol asString.
		].
]

{ #category : 'visiting' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> visitMessageExpressionRudesheim: aMessageExpressionTableQueryRudesheim [
	^ self
		error:	'SQLStringForExpressionSQLBackendTableQueryRudesheim: unsupported expression message'.
]

{ #category : 'visiting' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> visitObject: anObject [
	^ self
		error:	'SQLStringForExpressionSQLBackendTableQueryRudesheim: unsupported expression node'.
]

{ #category : 'visiting' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> visitParameterExpressionRudesheim: aParameterExpressionTableQueryRudesheim [
	^ '?'.
]

{ #category : 'visiting' }
SQLStringForExpressionSQLBackendTableQueryRudesheim >> visitProjectionExpressionRudesheim: aProjectionExpressionTableQueryRudesheim [
	^ self
		projectionSqlStringFor:	aProjectionExpressionTableQueryRudesheim expressions.
]
