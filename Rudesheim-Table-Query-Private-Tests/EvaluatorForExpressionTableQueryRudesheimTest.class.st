Class {
	#name : 'EvaluatorForExpressionTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Table-Query-Private-Tests-Evaluation',
	#package : 'Rudesheim-Table-Query-Private-Tests',
	#tag : 'Evaluation'
}

{ #category : 'accessing' }
EvaluatorForExpressionTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim TableQuery EvaluatorForExpression.
]

{ #category : 'accessing' }
EvaluatorForExpressionTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		rows:	{(3 -> 4) .  (10 -> 20)}
		parameters:	{100}.
]

{ #category : 'tests' }
EvaluatorForExpressionTableQueryRudesheimTest >> testVisitBinaryExpression [
	|
		expression
	|

	expression :=
	(
		Rudesheim TableQuery Expression Field
			table:	1
			field:	#key
	)
		=
		(
			Rudesheim TableQuery Expression Constant
				value:	3
		).

	self
		assert:
		(
			self basicTarget
				visit:	expression
		)
		equals:	true.
]

{ #category : 'tests' }
EvaluatorForExpressionTableQueryRudesheimTest >> testVisitConstantExpression [
	self
		assert:
		(
			self basicTarget
				visit:
				(
					Rudesheim TableQuery Expression Constant
						value:	42
				)
		)
		equals:	42.
]

{ #category : 'tests' }
EvaluatorForExpressionTableQueryRudesheimTest >> testVisitFieldExpression [
	|
		fieldExpression
	|

	fieldExpression := Rudesheim TableQuery Expression Field.

	self
		assert:
		(
			self basicTarget
				visit:
				(
					fieldExpression
						table:	1
				)
		)
		equals:	4.

	self
		assert:
		(
			self basicTarget
				visit:
				(
					fieldExpression
						table:	2
						field:	#key
				)
		)
		equals:	10.
]

{ #category : 'tests' }
EvaluatorForExpressionTableQueryRudesheimTest >> testVisitMessageExpression [
	|
		fieldExpression
		expression
	|

	fieldExpression := Rudesheim TableQuery Expression Field.

	expression :=
	(
		fieldExpression
			table:	1
			field:	#key
	)
		max:
		(
			fieldExpression
				table:	2
				field:	#key
		).

	self
		assert:
		(
			self basicTarget
				visit:	expression
		)
		equals:	10.
]

{ #category : 'tests' }
EvaluatorForExpressionTableQueryRudesheimTest >> testVisitParameterExpression [
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
		equals:	100.
]

{ #category : 'tests' }
EvaluatorForExpressionTableQueryRudesheimTest >> testVisitProjectionExpression [
	|
		fieldExpression
		expression
	|

	fieldExpression := Rudesheim TableQuery Expression Field.

	expression :=
		Rudesheim TableQuery Expression Projection
			expressions:
			{
				(
					fieldExpression
						table:	1
				).
				(
					fieldExpression
						table:	2
						field:	#key
				)
			}.

	self
		assert:
		(
			self basicTarget
				visit:	expression
		)
			asArray
		equals:	#(4 10).
]
