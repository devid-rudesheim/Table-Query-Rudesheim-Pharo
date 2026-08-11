Class {
	#name : 'ExpressionTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Table-Query-Private-Tests-Expression',
	#package : 'Rudesheim-Table-Query-Private-Tests',
	#tag : 'Expression'
}

{ #category : 'accessing' }
ExpressionTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim
		TableQuery
		FieldExpression.
]

{ #category : 'accessing' }
ExpressionTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		table:	1.
]

{ #category : 'tests' }
ExpressionTableQueryRudesheimTest >> testBinaryMessageCapture [
	|
		left
		right
		result
	|

	left :=
		Rudesheim
			TableQuery
			FieldExpression
			table:	1
			field:	#id.

	right :=
		Rudesheim
			TableQuery
			FieldExpression
			table:	2
			field:	#customerId.

	result := left = right.

	self
		assert:	result class
		equals:
		Rudesheim
			TableQuery
			BinaryExpression.

	self
		assert:
		result
			receiver
			== left.

	self
		assert:	result selector
		equals:	#=.

	self
		assert:
		result
			argument
			== right.
]

{ #category : 'tests' }
ExpressionTableQueryRudesheimTest >> testConstantWrapping [
	|
		result
	|

	result := (Rudesheim TableQuery FieldExpression table: 1 field: #total) > 100.

	self
		assert:
		result
			argument
			class
		equals:
		Rudesheim
			TableQuery
			ConstantExpression.

	self
		assert:
		result
			argument
			value
		equals:	100.
]

{ #category : 'tests' }
ExpressionTableQueryRudesheimTest >> testFieldResolution [
	|
		result
	|

	result := self basicTarget id.

	self
		assert:	result class
		equals:
		Rudesheim
			TableQuery
			FieldExpression.

	self
		assert:	result tableIndex
		equals:	1.

	self
		assert:	result fieldSelector
		equals:	#id.
]

{ #category : 'tests' }
ExpressionTableQueryRudesheimTest >> testKeywordMessageCapture [
	|
		result
	|

	result :=
		(
			Rudesheim
				TableQuery
				FieldExpression
				table:	1
				field:	#total
		)
			max:
			(
				Rudesheim
					TableQuery
					FieldExpression
					table:	2
					field:	#total
			).

	self
		assert:	result class
		equals:
		Rudesheim
			TableQuery
			MessageExpression.

	self
		assert:	result selector
		equals:	#max:.

	self
		assert:
		result
			arguments
			size
		equals:	1.
]

{ #category : 'tests' }
ExpressionTableQueryRudesheimTest >> testResolvedFieldFallsThroughToBinaryWrapping [
	|
		resolvedField
		result
	|

	resolvedField := self basicTarget total.
	result := resolvedField > 100.

	self
		assert:	result class
		equals:
		Rudesheim
			TableQuery
			BinaryExpression.

	self
		assert:
		result
			receiver
			== resolvedField.
]
