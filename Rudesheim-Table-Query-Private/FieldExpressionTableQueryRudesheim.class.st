"
A FieldExpressionTableQueryRudesheim represents either a whole-row placeholder for a table position (fieldSelector nil) or a resolved field on that row (fieldSelector set). Only a unary send to a whole-row placeholder resolves to another FieldExpressionTableQueryRudesheim; everything else falls through to ExpressionTableQueryRudesheim's generic wrapping.
"
Class {
	#name : 'FieldExpressionTableQueryRudesheim',
	#superclass : 'ExpressionTableQueryRudesheim',
	#instVars : [
		'tableIndex',
		'fieldSelector'
	],
	#category : 'Rudesheim-Table-Query-Private-Expression',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Expression'
}

{ #category : 'instance creation' }
FieldExpressionTableQueryRudesheim class >> table: anInteger [
	^ self
		table:	anInteger
		field:	nil.
]

{ #category : 'instance creation' }
FieldExpressionTableQueryRudesheim class >> table: anInteger
field: aSymbol [
	^ self new
		setTable:	anInteger
		field:	aSymbol.
]

{ #category : 'visiting' }
FieldExpressionTableQueryRudesheim >> acceptTVisitorRudesheim: aTVisitorRudesheim [
	^ aTVisitorRudesheim
		visitFieldExpressionRudesheim:	self.
]

{ #category : 'proxy' }
FieldExpressionTableQueryRudesheim >> doesNotUnderstand: aMessage [
	^
	(
		fieldSelector isNil
			and:
			[
				aMessage
					selector
					isUnary.
			]
	)
		ifTrue:
		[
			self class
				table:	tableIndex
				field:	aMessage selector.
		]
		ifFalse:
		[
			super
				doesNotUnderstand:	aMessage.
		].
]

{ #category : 'accessing' }
FieldExpressionTableQueryRudesheim >> fieldSelector [
	^ fieldSelector.
]

{ #category : 'initialization' }
FieldExpressionTableQueryRudesheim >> setTable: anInteger
field: aSymbol [
	tableIndex := anInteger.
	fieldSelector := aSymbol.
]

{ #category : 'accessing' }
FieldExpressionTableQueryRudesheim >> tableIndex [
	^ tableIndex.
]

{ #category : 'proxy' }
FieldExpressionTableQueryRudesheim >> value [
	|
		expression
	|
	
	expression := Rudesheim TableQuery Expression.

	^ fieldSelector
		ifNil:
		[
			expression Field
				table:	tableIndex
				field:	#value.
		]
		ifNotNil:
		[
			expression Message
				receiver:	self
				selector:	#value
				arguments:	#().
		].
]
