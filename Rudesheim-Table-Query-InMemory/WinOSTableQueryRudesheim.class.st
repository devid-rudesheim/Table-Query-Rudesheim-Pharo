"
Overrides OSTableQueryRudesheim (its superclass) for Windows, reached as `Smalltalk os rudesheim tableQuery` on Windows. Drops the DMirror-backed plans, because DMirror declares its own OSSubprocess dependency, which is POSIX-only and unavailable on Windows; falls back to SmallInputSequential/EqualityIntersection (and, if neither optimizer accepts the query, plain sequential iteration).
"
Class {
	#name : 'WinOSTableQueryRudesheim',
	#superclass : 'OSTableQueryRudesheim',
	#category : 'Rudesheim-Table-Query-InMemory-OS',
	#package : 'Rudesheim-Table-Query-InMemory',
	#tag : 'OS'
}

{ #category : 'optimization' }
WinOSTableQueryRudesheim class >> optimizers [
	|
		plan
	|

	plan := Rudesheim TableQuery Backend InMemory Plan.

	^
	{
		plan SmallInputSequential.
		plan EqualityIntersection
	}.
]
