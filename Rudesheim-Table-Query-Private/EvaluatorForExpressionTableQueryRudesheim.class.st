"
An EvaluatorForExpressionTableQueryRudesheim walks an ExpressionTableQueryRudesheim tree against a concrete row-tuple / parameter-value binding and computes the real value. Used by SQL backend verification drivers now, and intended for reuse by the InMemory backend's tree-evaluation execution strategy later.
"
Class {
	#name : 'EvaluatorForExpressionTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TVisitorRudesheim + TShouldntNewRudesheim',
	#classTraits : 'TVisitorRudesheim classTrait + TShouldntNewRudesheim classTrait',
	#instVars : [
		'rowBindings',
		'parameterBindings'
	],
	#category : 'Rudesheim-Table-Query-Private-Evaluation',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Evaluation'
}

{ #category : 'instance creation' }
EvaluatorForExpressionTableQueryRudesheim class >> rows: aRowCollection
parameters: aParameterCollection [
	^ super new
		setRows:	aRowCollection
		parameters:	aParameterCollection.
]

{ #category : 'initialization' }
EvaluatorForExpressionTableQueryRudesheim >> setRows: aRowCollection
parameters: aParameterCollection [
	rowBindings := aRowCollection.
	parameterBindings := aParameterCollection.
]

{ #category : 'visiting' }
EvaluatorForExpressionTableQueryRudesheim >> visitBinaryExpressionRudesheim: aBinaryExpressionTableQueryRudesheim [
	^
	(
		self
			visit:	aBinaryExpressionTableQueryRudesheim receiver
	)
		perform:	aBinaryExpressionTableQueryRudesheim selector
		with:
		(
			self
				visit:	aBinaryExpressionTableQueryRudesheim argument
		).
]

{ #category : 'visiting' }
EvaluatorForExpressionTableQueryRudesheim >> visitConstantExpressionRudesheim: aConstantExpressionTableQueryRudesheim [
	^ aConstantExpressionTableQueryRudesheim value.
]

{ #category : 'visiting' }
EvaluatorForExpressionTableQueryRudesheim >> visitFieldExpressionRudesheim: aFieldExpressionTableQueryRudesheim [
	|
		row
	|

	row :=
		rowBindings
			at:	aFieldExpressionTableQueryRudesheim tableIndex.

	^ aFieldExpressionTableQueryRudesheim fieldSelector
		ifNil:
		[
			row value.
		]
		ifNotNil:
		[ :aFieldSelector |
			row
				perform:	aFieldSelector.
		].
]

{ #category : 'visiting' }
EvaluatorForExpressionTableQueryRudesheim >> visitMessageExpressionRudesheim: aMessageExpressionTableQueryRudesheim [
	|
		evaluatedArguments
	|

	evaluatedArguments :=
		aMessageExpressionTableQueryRudesheim arguments
			collect:
			[ :eachArgument |
				self
					visit:	eachArgument.
			].

	^
	(
		self
			visit:	aMessageExpressionTableQueryRudesheim receiver
	)
		perform:	aMessageExpressionTableQueryRudesheim selector
		withArguments:	evaluatedArguments asArray.
]

{ #category : 'visiting' }
EvaluatorForExpressionTableQueryRudesheim >> visitObject: anObject [
	^ self
		error:	'EvaluatorForExpressionTableQueryRudesheim: unsupported expression node'.
]

{ #category : 'visiting' }
EvaluatorForExpressionTableQueryRudesheim >> visitParameterExpressionRudesheim: aParameterExpressionTableQueryRudesheim [
	^ parameterBindings
		at:	aParameterExpressionTableQueryRudesheim index.
]

{ #category : 'visiting' }
EvaluatorForExpressionTableQueryRudesheim >> visitProjectionExpressionRudesheim: aProjectionExpressionTableQueryRudesheim [
	^ aProjectionExpressionTableQueryRudesheim expressions
		collect:
		[ :eachExpression |
			self
				visit:	eachExpression.
		].
]
