"
Test fixture row object shared by table query backend tests, reproducing the customers/orders example from note/table-query-redesign.md.
"
Class {
	#name : 'OrderFixtureForTestTableQueryRudesheim',
	#superclass : 'Object',
	#instVars : [
		'customerId',
		'total'
	],
	#category : 'Rudesheim-Table-Query-Tests-Fixtures',
	#package : 'Rudesheim-Table-Query-Tests',
	#tag : 'Fixtures'
}

{ #category : 'instance creation' }
OrderFixtureForTestTableQueryRudesheim class >> customerId: anInteger
total: aNumber [
	^ self new
		setCustomerId:	anInteger
		total:	aNumber.
]

{ #category : 'accessing' }
OrderFixtureForTestTableQueryRudesheim >> customerId [
	^ customerId.
]

{ #category : 'initialization' }
OrderFixtureForTestTableQueryRudesheim >> setCustomerId: anInteger
total: aNumber [
	customerId := anInteger.
	total := aNumber.
]

{ #category : 'accessing' }
OrderFixtureForTestTableQueryRudesheim >> total [
	^ total.
]
