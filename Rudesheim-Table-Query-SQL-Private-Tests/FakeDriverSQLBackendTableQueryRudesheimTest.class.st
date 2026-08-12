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
	|

	numbersTable :=
		Rudesheim
			TableQuery
			Backend
			SQL
			Table
			name:	#numbers.

	whereExpression :=
		Rudesheim
			TableQuery
			ConstantExpression
			value:	true.

	selectExpression :=
		Rudesheim
			TableQuery
			ConstantExpression
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
		assert:
		compiledStatement
			tables
			asArray
			= (Array with: numbersTable).

	self
		assert:
		compiledStatement
			whereExpression
			== whereExpression.

	self
		assert:
		compiledStatement
			selectExpression
			== selectExpression.
]

{ #category : 'tests' }
FakeDriverSQLBackendTableQueryRudesheimTest >> testExecuteWithEvaluatesWhereAndCollectsSelect [
	|
		compiledStatement
		result
	|

	compiledStatement :=
		self basicTarget
			compileSelectFrom:
			(
				Array
					with:
					(
						Rudesheim
							TableQuery
							Backend
							SQL
							Table
							name:	#numbers
					)
			)
			where:
			(
				Rudesheim
					TableQuery
					FieldExpression
					table:	1
			)
				> (Rudesheim TableQuery ParameterExpression index: 1)
			select:
			(
				Rudesheim
					TableQuery
					FieldExpression
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
	|

	compiledStatement :=
		self basicTarget
			compileSelectFrom:
			(
				Array
					with:
					(
						Rudesheim
							TableQuery
							Backend
							SQL
							Table
							name:	#numbers
					)
			)
			where:
			(
				Rudesheim
					TableQuery
					FieldExpression
					table:	1
					field:	#id
			)
				> (Rudesheim TableQuery ParameterExpression index: 1)
			select:
			(
				Rudesheim
					TableQuery
					FieldExpression
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
	|

	compiledStatement :=
		self basicTarget
			compileSelectFrom:
			(
				Array
					with:
					(
						Rudesheim
							TableQuery
							Backend
							SQL
							Table
							name:	#numbers
					)
			)
			where:
			(
				Rudesheim
					TableQuery
					ConstantExpression
					value:	true
			)
			select:
			(
				Rudesheim
					TableQuery
					FieldExpression
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
