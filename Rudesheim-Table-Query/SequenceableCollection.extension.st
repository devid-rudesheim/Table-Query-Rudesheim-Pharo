Extension { #name : 'SequenceableCollection' }

{ #category : '*Rudesheim-Table-Query' }
SequenceableCollection >> asRHTableQuery [

	^ Rudesheim
		TableQuery
		QuerySource
		fromCollections:	self.
]
