"
A ParameterCaptureTableQueryRudesheim is the ""parameters"" argument handed to a #prepareTableQuery:from: capture block. Each access by index lazily mints and caches a ParameterExpressionTableQueryRudesheim, so the same index reused twice in one block yields the identical placeholder node.
"
Class {
	#name : 'ParameterCaptureTableQueryRudesheim',
	#superclass : 'Object',
	#instVars : [
		'cache'
	],
	#category : 'Rudesheim-Table-Query-Private-Statement',
	#package : 'Rudesheim-Table-Query-Private',
	#tag : 'Statement'
}

{ #category : 'accessing' }
ParameterCaptureTableQueryRudesheim >> at: anIndex [
	|
		tableQuery
	|

	tableQuery := Rudesheim TableQuery.

	^ cache
		at:	anIndex
		ifAbsentPut:
		[
			tableQuery ExpressionCaptureDelegator
				delegateTo:
				(
					tableQuery Expression Parameter
						index:	anIndex
				).
		].
]

{ #category : 'accessing' }
ParameterCaptureTableQueryRudesheim >> fifth [
	^ self
		at:	5.
]

{ #category : 'accessing' }
ParameterCaptureTableQueryRudesheim >> first [
	^ self
		at:	1.
]

{ #category : 'accessing' }
ParameterCaptureTableQueryRudesheim >> fourth [
	^ self
		at:	4.
]

{ #category : 'initialization' }
ParameterCaptureTableQueryRudesheim >> initialize [
	super initialize.
	cache := Dictionary new.
]

{ #category : 'accessing' }
ParameterCaptureTableQueryRudesheim >> second [
	^ self
		at:	2.
]

{ #category : 'accessing' }
ParameterCaptureTableQueryRudesheim >> third [
	^ self
		at:	3.
]
