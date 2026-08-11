Class {
	#name : 'DMirrorSupportInMemoryBackendTableQueryRudesheim',
	#superclass : 'Object',
	#category : 'Rudesheim-Table-Query-InMemory-Private-Optimization',
	#package : 'Rudesheim-Table-Query-InMemory-Private',
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

{ #category : 'actions' }
DMirrorSupportInMemoryBackendTableQueryRudesheim class >> ensurePlayCacheDirectory [
	(
		FileLocator workingDirectory
			/ 'pharo-local'
			/ 'play-cache'
	)
		ensureCreateDirectory.
]
