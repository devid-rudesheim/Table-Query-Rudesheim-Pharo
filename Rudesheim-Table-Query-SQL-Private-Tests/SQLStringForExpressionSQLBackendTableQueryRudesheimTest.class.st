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
	|
		table
	|

	table := 	Rudesheim TableQuery Backend SQL Table.

	^ self targetClass
		tables:
		{
			(
				table
					name:	#customers
			).
			(
				table
					name:	#orders
			)
		}.
]

{ #category : 'tests' }
SQLStringForExpressionSQLBackendTableQueryRudesheimTest >> testVisitBinaryExpressionRudesheim [
	|
		expression
		expressionSpace
		field
	|

	expressionSpace := Rudesheim TableQuery Expression.
	field := expressionSpace Field.
	expression := (field table: 1 field: #id) = (field table: 2 field: #customerId) & ((field table: 2 field: #total) > (expressionSpace Parameter index: 1)).

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
					Rudesheim TableQuery Expression Field
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
					Rudesheim TableQuery Expression Parameter
						index:	1
				)
		)
		equals:	'?'.
]

{ #category : 'tests' }
SQLStringForExpressionSQLBackendTableQueryRudesheimTest >> testVisitProjectionExpressionRudesheim [
	|
		expression
		expressionSpace
		field
	|

	expressionSpace := Rudesheim TableQuery Expression.
	field := expressionSpace Field.

	expression :=
		expressionSpace Projection
			expressions:
			{
				(
					field
						table:	1
						field:	#id
				).
				(
					field
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
		expressionSpace
	|

	expressionSpace := Rudesheim TableQuery Expression.

	expression :=
		expressionSpace Projection
			expressions:
			{
				(
					expressionSpace Field
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
		expressionSpace
		field
	|

	expressionSpace := Rudesheim TableQuery Expression.
	field := expressionSpace Field.

	expression :=
		expressionSpace Projection
			expressions:
			{
				(
					field
						table:	1
						field:	#id
				).
				(
					field
						table:	1
						field:	#name
				).
				(
					field
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
