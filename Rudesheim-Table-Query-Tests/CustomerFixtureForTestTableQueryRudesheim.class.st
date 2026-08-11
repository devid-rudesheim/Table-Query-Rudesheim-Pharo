"
Test fixture row object shared by table query backend tests, reproducing the customers/orders example from note/table-query-redesign.md.
"
Class {
	#name : 'CustomerFixtureForTestTableQueryRudesheim',
	#superclass : 'Object',
	#instVars : [
		'id',
		'name'
	],
	#category : 'Rudesheim-Table-Query-Tests-Fixtures',
	#package : 'Rudesheim-Table-Query-Tests',
	#tag : 'Fixtures'
}

{ #category : 'instance creation' }
CustomerFixtureForTestTableQueryRudesheim class >> id: anInteger
name: aString [
	^ self new
		setId:	anInteger
		name:	aString.
]

{ #category : 'accessing' }
CustomerFixtureForTestTableQueryRudesheim >> id [
	^ id.
]

{ #category : 'accessing' }
CustomerFixtureForTestTableQueryRudesheim >> name [
	^ name.
]

{ #category : 'initialization' }
CustomerFixtureForTestTableQueryRudesheim >> setId: anInteger
name: aString [
	id := anInteger.
	name := aString.
]
