Class {
	#name : 'IteratorTableQueryRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewUtilityRudesheim',
	#classTraits : 'TShouldntNewUtilityRudesheim classTrait',
	#instVars : [
		'rows',
		'loop'
	],
	#category : 'Rudesheim-Table-Query-Private-Query',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Query'
}

{ #category : 'instance creation' }
IteratorTableQueryRudesheim class >> fromCollections: aCollection [
	^ super new
		collections:	aCollection.
]

{ #category : 'accessing' }
IteratorTableQueryRudesheim >> collections: aCollection [
	|
		collections
	|

	collections := aCollection.
	rows := self defaultRows.

	collections isEmpty
		ifTrue:
		[
			loop :=
				[ :block |
				].

			^ self.
		].

	loop :=
		collections
			inject:
			[ :block |
				block value.
			]
			into:
			[ :subLoop :table |
				|
					rowProxy
				|

				rowProxy := self defaultRowProxy.

				rows
					add:
					(
						Rudesheim Utility Delegator ForAccessing
							targetFrom:	#value
							of:	rowProxy
					).

				[ :block |
					table
						do:
						[ :row |
							rowProxy
								value:	row.

							subLoop
								value:	block.
						].
				].
			].
]

{ #category : 'accessing' }
IteratorTableQueryRudesheim >> defaultRowProxy [
	^ NewValueHolder new.
]

{ #category : 'accessing' }
IteratorTableQueryRudesheim >> defaultRows [
	^ OrderedCollection new.
]

{ #category : 'accessing' }
IteratorTableQueryRudesheim >> rows [
	^ rows
		ifNil:
		[
			rows := self defaultRows.
		].
]

{ #category : 'accessing' }
IteratorTableQueryRudesheim >> rows: anObject [
	rows := anObject.
]

{ #category : 'iteration' }
IteratorTableQueryRudesheim >> timesRepeat: aBlock [
	loop
		value:	aBlock.
]
