"
A SQLStringForExpressionSQLBackendTableQueryRudesheimTest is a test class for testing the behavior of Rudesheim TableQuery Backend SQL SQLStringForExpression
"
Class {
	#name : 'SQLStringForExpressionSQLBackendTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Table-Query-SQL-Private-Tests-Rendering',
	#package : 'Rudesheim-Table-Query-SQL-Private-Tests',
	#tag : 'Rendering'
}

{ #category : 'accessing' }
SQLStringForExpressionSQLBackendTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim
		TableQuery
		Backend
		SQL
		SQLStringForExpression.
]

{ #category : 'accessing' }
SQLStringForExpressionSQLBackendTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		tables:
		{
			(
				Rudesheim
					TableQuery
					Backend
					SQL
					Table
					name:	#customers
			).
			(
				Rudesheim
					TableQuery
					Backend
					SQL
					Table
					name:	#orders
			)
		}.
]

{ #category : 'tests' }
SQLStringForExpressionSQLBackendTableQueryRudesheimTest >> testVisitBinaryExpressionRudesheim [
	|
		expression
	|

	expression := (Rudesheim TableQuery FieldExpression table: 1 field: #id) = (Rudesheim TableQuery FieldExpression table: 2 field: #customerId) & ((Rudesheim TableQuery FieldExpression table: 2 field: #total) > (Rudesheim TableQuery ParameterExpression index: 1)).

	self
		assert:
		(
			self basicTarget
				visit:	expression
		)
		equals:	'((t1.id = t2.customerId) AND (t2.total > ?))'.
]

{ #category : 'tests' }
SQLStringForExpressionSQLBackendTableQueryRudesheimTest >> testVisitFieldExpressionRudesheim [
	self
		assert:
		(
			self basicTarget
				visit:
				(
					Rudesheim
						TableQuery
						FieldExpression
						table:	1
						field:	#name
				)
		)
		equals:	't1.name'.
]

{ #category : 'tests' }
SQLStringForExpressionSQLBackendTableQueryRudesheimTest >> testVisitParameterExpressionRudesheim [
	self
		assert:
		(
			self basicTarget
				visit:
				(
					Rudesheim
						TableQuery
						ParameterExpression
						index:	1
				)
		)
		equals:	'?'.
]

{ #category : 'tests' }
SQLStringForExpressionSQLBackendTableQueryRudesheimTest >> testVisitProjectionExpressionRudesheim [
	|
		expression
	|

	expression :=
		Rudesheim
			TableQuery
			ProjectionExpression
			expressions:
			{
				(
					Rudesheim
						TableQuery
						FieldExpression
						table:	1
						field:	#id
				).
				(
					Rudesheim
						TableQuery
						FieldExpression
						table:	1
						field:	#name
				)
			}.

	self
		assert:
		(
			self basicTarget
				visit:	expression
		)
		equals:	't1.id, t1.name'.
]

{ #category : 'tests' }
SQLStringForExpressionSQLBackendTableQueryRudesheimTest >> testVisitProjectionExpressionRudesheimWithOneColumn [
	|
		expression
	|

	expression :=
		Rudesheim
			TableQuery
			ProjectionExpression
			expressions:
			{
				(
					Rudesheim
						TableQuery
						FieldExpression
						table:	1
						field:	#id
				)
			}.

	self
		assert:
		(
			self basicTarget
				visit:	expression
		)
		equals:	't1.id'.
]

{ #category : 'tests' }
SQLStringForExpressionSQLBackendTableQueryRudesheimTest >> testVisitProjectionExpressionRudesheimWithThreeColumns [
	|
		expression
	|

	expression :=
		Rudesheim
			TableQuery
			ProjectionExpression
			expressions:
			{
				(
					Rudesheim
						TableQuery
						FieldExpression
						table:	1
						field:	#id
				).
				(
					Rudesheim
						TableQuery
						FieldExpression
						table:	1
						field:	#name
				).
				(
					Rudesheim
						TableQuery
						FieldExpression
						table:	2
						field:	#total
				)
			}.

	self
		assert:
		(
			self basicTarget
				visit:	expression
		)
		equals:	't1.id, t1.name, t2.total'.
]
