"
FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim is a verification-only concrete RDB driver. It does not talk to a real database; it interprets the captured expression tree directly against its own toy in-memory tables, to prove the block -> expression-tree capture -> driver compile -> driver execute path works before a real DB driver exists.
"
Class {
	#name : 'FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TRelationalDatabaseDriverSQLBackendTableQueryRudesheim + TShouldntNewRudesheim',
	#classTraits : 'TRelationalDatabaseDriverSQLBackendTableQueryRudesheim classTrait + TShouldntNewRudesheim classTrait',
	#instVars : [
		'tablesByName'
	],
	#category : 'Rudesheim-Table-Query-SQL-Private-Driver',
	#package : 'Rudesheim-Table-Query-SQL-Private',
	#tag : 'Driver'
}

{ #category : 'namespace' }
FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim class >> CompiledStatement [
	^ CompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim.
]

{ #category : 'instance creation' }
FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim class >> tables: aCollectionOfAssociations [
	^ super new
		setTables:	aCollectionOfAssociations.
]

{ #category : 'compiling' }
FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> compileSelectFrom: aCollectionOfTables
where: aWhereExpressionTableQueryRudesheim
select: aSelectExpressionTableQueryRudesheim [
	^ CompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim
		tables:	aCollectionOfTables
		where:	aWhereExpressionTableQueryRudesheim
		select:	aSelectExpressionTableQueryRudesheim.
]

{ #category : 'evaluating' }
FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> execute: aCompiledStatement
with: aCollectionOfParameterValues [
	|
		resolvedTables
		iterator
		results
		block
	|

	resolvedTables :=
		aCompiledStatement tables
			collect:
			[ :eachTable |
				tablesByName
					at:	eachTable name.
			].

	iterator :=
		IteratorTableQueryRudesheim
			fromCollections:	resolvedTables.

	results := OrderedCollection new.

	block :=
		[
			|
				evaluator
			|

			evaluator :=
				EvaluatorForExpressionTableQueryRudesheim
					rows:	iterator rows
					parameters:	aCollectionOfParameterValues.

			(
				evaluator
					visit:	aCompiledStatement whereExpression
			)
				ifTrue:
				[
					results
						add:
						(
							evaluator
								visit:	aCompiledStatement selectExpression
						).
				].
		].

	iterator
		timesRepeat:	block.

	^ results.
]

{ #category : 'initialization' }
FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> setTables: aCollectionOfAssociations [
	tablesByName := Dictionary new.

	aCollectionOfAssociations
		do:
		[ :eachAssociation |
			tablesByName
				at:	eachAssociation key
				put:	eachAssociation value.
		].
]

{ #category : 'private' }
FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> shouldOmitWhereClauseFor: anExpressionTableQueryRudesheim [
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
FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> sqlStringFor: aCompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim [
	|
		expressionRenderer
	|

	expressionRenderer :=
		SQLStringForExpressionSQLBackendTableQueryRudesheim
			tables:	aCompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim tables.

	^ String
		streamContents:
		[ :aStream |
			aStream
				nextPutAll:	'SELECT ';
				nextPutAll:
				(
					expressionRenderer
						visit:	aCompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim selectExpression
				);
				nextPutAll:	' FROM ';
				nextPutAll:
				(
					self
						tablesSqlStringFor:	aCompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim tables
				).

			(
				self
					shouldOmitWhereClauseFor:	aCompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim whereExpression
			)
				ifFalse:
				[
					aStream
						nextPutAll:	' WHERE ';
						nextPutAll:
						(
							expressionRenderer
								visit:	aCompiledStatementForFakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim whereExpression
						).
				].
		].
]

{ #category : 'private' }
FakeRelationalDatabaseDriverSQLBackendTableQueryRudesheim >> tablesSqlStringFor: aCollectionOfTables [
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
