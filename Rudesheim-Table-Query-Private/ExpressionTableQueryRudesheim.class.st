"
An ExpressionTableQueryRudesheim is an abstract syntax tree node captured from a plain Smalltalk block by wrapping messages sent to a symbolic placeholder (see FieldExpressionTableQueryRudesheim / ParameterExpressionTableQueryRudesheim) instead of evaluating them.

Nodes override #= (since Object>>= already exists and would never trigger #doesNotUnderstand:), so they must never be used as Dictionary/Set keys or compared with #assert:equals: in tests.
"
Class {
	#name : 'ExpressionTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'THostForVisitorRudesheim + TExpressionTableQueryRudesheim',
	#classTraits : 'THostForVisitorRudesheim classTrait + TExpressionTableQueryRudesheim classTrait',
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}
