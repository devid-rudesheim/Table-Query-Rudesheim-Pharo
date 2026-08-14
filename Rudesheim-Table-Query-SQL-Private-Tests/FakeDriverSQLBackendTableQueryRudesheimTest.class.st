Class {
	#name : 'FakeDriverSQLBackendTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Table-Query-SQL-Private-Tests-Driver',
	#package : 'Rudesheim-Table-Query-SQL-Private-Tests',
	#tag : 'Driver'
}

{ #category : 'accessing' }
FakeDriverSQLBackendTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim TableQuery Backend SQL Driver Fake.
]

{ #category : 'accessing' }
FakeDriverSQLBackendTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		tables:	{(#numbers -> #(1 2 3 4 5))}.
]

{ #category : 'tests' }
FakeDriverSQLBackendTableQueryRudesheimTest >> testCompileSelectFromWhereSelectPackagesArgumentsVerbatim [
	|
		numbersTable
		whereExpression
		selectExpression
		compiledStatement
		tableQuery
		constant
	|
	
	tableQuery := Rudesheim TableQuery.
	constant := tableQuery Expression Constant.

	numbersTable :=
		tableQuery Backend SQL Table
			name:	#numbers.

	whereExpression :=
		constant
			value:	true.

	selectExpression :=
		constant
			value:	1.

	compiledStatement :=
		self basicTarget
			compileSelectFrom:
			(
				Array
					with:	numbersTable
			)
			where:	whereExpression
			select:	selectExpression.

	self
		assert: compiledStatement tables asArray = (Array with: numbersTable).

	self
		assert: compiledStatement whereExpression == whereExpression.

	self
		assert: compiledStatement selectExpression	== selectExpression.
]

{ #category : 'tests' }
FakeDriverSQLBackendTableQueryRudesheimTest >> testExecuteWithEvaluatesWhereAndCollectsSelect [
	|
		compiledStatement
		result
		tableQuery
		expression
		field
	|
	
	tableQuery := Rudesheim TableQuery.
	expression := tableQuery Expression.
	field := expression Field.

	compiledStatement :=
		self basicTarget
			compileSelectFrom:
			(
				Array
					with:
					(
						tableQuery Backend SQL Table
							name:	#numbers
					)
			)
			where:
			(
				field
					table:	1
			) > (expression Parameter index: 1)
			select:
			(
				field
					table:	1
			).

	result :=
		self basicTarget
			execute:	compiledStatement
			with:	{2}.

	self
		assertCollection:	result asArray
		hasSameElements:	#(3 4 5).
]

{ #category : 'tests' }
FakeDriverSQLBackendTableQueryRudesheimTest >> testSqlStringForCompiledStatement [
	|
		compiledStatement
		tableQuery
		expression
		field
	|

	tableQuery := Rudesheim TableQuery.
	expression := tableQuery Expression.
	field := expression Field.

	compiledStatement :=
		self basicTarget
			compileSelectFrom:
			(
				Array
					with:
					(
						tableQuery Backend SQL Table
							name:	#numbers
					)
			)
			where:
			(
				field
					table:	1
					field:	#id
			) > (expression Parameter index: 1)
			select:
			(
				field
					table:	1
					field:	#id
			).

	self
		assert:
		(
			self basicTarget
				sqlStringFor:	compiledStatement
		)
		equals:	'SELECT t1.id FROM numbers t1 WHERE (t1.id > ?)'.
]

{ #category : 'tests' }
FakeDriverSQLBackendTableQueryRudesheimTest >> testSqlStringForCompiledStatementWithoutWhere [
	|
		compiledStatement
		tableQuery
		expresion
	|
	
	tableQuery := Rudesheim TableQuery.
	expresion := tableQuery Expression.

	compiledStatement :=
		self basicTarget
			compileSelectFrom:
			(
				Array
					with:
					(
						tableQuery Backend SQL Table
							name:	#numbers
					)
			)
			where:
			(
				expresion Constant
					value:	true
			)
			select:
			(
				expresion Field
					table:	1
			).

	self
		assert:
		(
			self basicTarget
				sqlStringFor:	compiledStatement
		)
		equals:	'SELECT t1 FROM numbers t1'.
]
