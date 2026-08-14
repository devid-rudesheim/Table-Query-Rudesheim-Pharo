Class {
	#name : 'ExpressionTableQueryRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Table-Query-Private-Tests-Expression',
	#package : 'Rudesheim-Table-Query-Private-Tests',
	#tag : 'Expression'
}

{ #category : 'accessing' }
ExpressionTableQueryRudesheimTest class >> targetClass [
	^ Rudesheim TableQuery Expression Field.
]

{ #category : 'accessing' }
ExpressionTableQueryRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		table:	1.
]

{ #category : 'tests' }
ExpressionTableQueryRudesheimTest >> testBinaryMessageCapture [
	|
		fieldExpression
		left
		right
		result
	|

	fieldExpression := Rudesheim TableQuery Expression Field.

	left :=
		fieldExpression
			table:	1
			field:	#id.

	right :=
		fieldExpression
			table:	2
			field:	#customerId.

	result := left = right.

	self
		assert:	result class
		equals:	Rudesheim TableQuery Expression Binary.

	self
		assert:	result receiver == left.

	self
		assert:	result selector
		equals:	#=.

	self
		assert:	result argument == right.
]

{ #category : 'tests' }
ExpressionTableQueryRudesheimTest >> testConstantWrapping [
	|
		result
	|

	result :=
		(
			Rudesheim TableQuery Expression Field
				table:	1
				field:	#total
		)
			> 100.

	self
		assert:	result argument class
		equals:	Rudesheim TableQuery Expression Constant.

	self
		assert:	result argument value
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
		equals:	Rudesheim TableQuery Expression Field.

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
		fieldExpression
		result
	|

	fieldExpression := Rudesheim TableQuery Expression Field.

	result :=
		(
			fieldExpression
				table:	1
				field:	#total
		)
			max:
			(
				fieldExpression
					table:	2
					field:	#total
			).

	self
		assert:	result class
		equals:	Rudesheim TableQuery Expression Message.

	self
		assert:	result selector
		equals:	#max:.

	self
		assert:	result arguments size
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
		equals:	Rudesheim TableQuery Expression Binary.

	self
		assert:	result receiver == resolvedField.
]
