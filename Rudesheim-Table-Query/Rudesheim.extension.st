Extension { #name : 'Rudesheim' }

{ #category : '*Rudesheim-Table-Query' }
Rudesheim class >> TableQuery [

	^ TableQueryRudesheim
]

{ #category : '*Rudesheim-Table-Query' }
Rudesheim class >> TableQuerySQL [

	^ self TableQuery Backend SQL
]
