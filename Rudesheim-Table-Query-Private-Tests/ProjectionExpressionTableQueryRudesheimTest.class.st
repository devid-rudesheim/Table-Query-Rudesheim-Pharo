"
A ProjectionExpressionTableQueryRudesheimTest is a test class for testing the behavior of Rudesheim TableQuery Expression Projection
"
Class {
	#name : 'ProjectionExpressionTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Table-Query-Private-Tests-Expression',
	#package : 'Rudesheim-Table-Query-Private-Tests',
	#tag : 'Expression'
}

{ #category : 'accessing' }
ProjectionExpressionTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim
		TableQuery
		Expression
		Projection.
]

{ #category : 'tests' }
ProjectionExpressionTableQueryRudesheimTest >> testExpressionWrapping [
	|
		expressions
		projectionExpression
	|

	expressions :=
	{
		(
			Rudesheim
				TableQuery
				Expression
				Field
				table:	1
				field:	#id
		).
		(
			Rudesheim
				TableQuery
				Expression
				Field
				table:	1
				field:	#name
		)
	}.
	projectionExpression := expressions asTableQueryProjectionExpressionRudesheim.

	self
		assert:	projectionExpression class
		equals:	self targetClass.

	self
		assert:	projectionExpression expressions size
		equals:	expressions size.

	projectionExpression expressions
		with:	expressions
		do:
		[ :eachActual :eachExpected |
			self
				assert:	(eachActual == eachExpected).
		].
]

{ #category : 'tests' }
ProjectionExpressionTableQueryRudesheimTest >> testExpressions [
	|
		expressions
		projectionExpression
	|

	expressions :=
	{
		(
			Rudesheim
				TableQuery
				Expression
				Field
				table:	1
				field:	#id
		).
		(
			Rudesheim
				TableQuery
				Expression
				Field
				table:	1
				field:	#name
		)
	}.

	projectionExpression :=
		self targetClass
			expressions:	expressions.

	self
		assert:
		(
			projectionExpression
				expressions
				asArray
				== expressions
		).
]
