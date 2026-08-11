"
A ProjectionExpressionTableQueryRudesheimTest is a test class for testing the behavior of Rudesheim TableQuery ProjectionExpression
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
		ProjectionExpression.
]

{ #category : 'tests' }
ProjectionExpressionTableQueryRudesheimTest >> testExpressionWrapping [
	|
		expressions
		projectionExpression
	|

	expressions := {(Rudesheim TableQuery FieldExpression table: 1 field: #id) .  (Rudesheim TableQuery FieldExpression table: 1 field: #name)}.
	projectionExpression := expressions asTableQueryProjectionExpressionRudesheim.

	self
		assert:	projectionExpression class
		equals:	self targetClass.

	self
		assert:
		projectionExpression
			expressions
			asArray
		equals:	expressions.
]

{ #category : 'tests' }
ProjectionExpressionTableQueryRudesheimTest >> testExpressions [
	|
		expressions
		projectionExpression
	|

	expressions := {(Rudesheim TableQuery FieldExpression table: 1 field: #id) .  (Rudesheim TableQuery FieldExpression table: 1 field: #name)}.

	projectionExpression :=
		self targetClass
			expressions:	expressions.

	self
		assert:
		projectionExpression
			expressions
			asArray
		equals:	expressions.
]
