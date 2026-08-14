Class {
	#name : 'DMirrorSupportInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#category : 'Rudesheim-Table-Query-InMemory-DMirror-Private-Optimization',
	#package : 'Rudesheim-Table-Query-InMemory-DMirror-Private',
	#tag : 'Optimization'
}

{ #category : 'private' }
DMirrorSupportInMemoryBackendTableQueryRudesheim class >> combinationSizeOf: aCollection [
	|
		combinationSize
	|

	combinationSize := 1.

	aCollection
		do:
		[ :eachCollection |
			combinationSize := combinationSize * eachCollection size.
		].

	^ combinationSize.
]

{ #category : 'actions' }
DMirrorSupportInMemoryBackendTableQueryRudesheim class >> ensurePlayCacheDirectory [
	( FileLocator workingDirectory / 'pharo-local' / 'play-cache' )
		ensureCreateDirectory.
]

{ #category : 'private' }
DMirrorSupportInMemoryBackendTableQueryRudesheim class >> minimumCollectionSizeOf: aCollection [
	^
	(
		aCollection
			detectMin:
			[ :eachCollection |
				eachCollection size.
			]
	) size.
]
