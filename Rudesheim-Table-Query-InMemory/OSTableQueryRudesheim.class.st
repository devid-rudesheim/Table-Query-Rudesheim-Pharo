"
Default/base optimizer table for the in-memory backend, reached as `Smalltalk os rudesheim tableQuery` on a POSIX-like OS (including macOS, via inheritance from MacOSRudesheim < OSRudesheim). Includes the DMirror-backed plans, which require the optional `dmirror` load group (see the Table-Query README) because DMirror declares its own OSSubprocess dependency, which is POSIX-only. WinOSTableQueryRudesheim overrides #optimizers for Windows to drop those plans.
"
Class {
	#name : 'OSTableQueryRudesheim',
	#superclass : 'Object',
	#category : 'Rudesheim-Table-Query-InMemory-OS',
	#package : 'Rudesheim-Table-Query-InMemory',
	#tag : 'OS'
}

{ #category : 'optimization' }
OSTableQueryRudesheim class >> optimizers [
	|
		plan
	|

	plan := Rudesheim TableQuery Backend InMemory Plan.

	^
	{
		plan SmallInputSequential.
		plan DMirror EqualityIntersection.
		plan EqualityIntersection.
		plan DMirror Sequential
	}.
]
