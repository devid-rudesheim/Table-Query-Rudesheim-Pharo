Class {
	#name : 'BaselineOfRudesheimTableQuery',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfRudesheimTableQuery',
	#package : 'BaselineOfRudesheimTableQuery'
}

{ #category : 'baselines' }
BaselineOfRudesheimTableQuery >> baseline: spec [
	<baseline>

	spec
		for: #common
		do:
		[
			spec
				baseline: 'RudesheimUtility'
				with:
				[
					spec repository: 'github://devid-rudesheim/Utility-Rudesheim-Pharo:main'
				];

				project: 'RudesheimUtilityTests'
				copyFrom: 'RudesheimUtility'
				with:
				[
					spec loads: #( 'tests' )
				];

				baseline: 'RudesheimKernel'
				with:
				[
					spec repository: 'github://devid-rudesheim/Kernel-Rudesheim-Pharo:main'
				];

				baseline: 'SQLite3'
				with: [ spec repository: 'github://pharo-rdbms/Pharo-SQLite3/src' ];

				package: 'Rudesheim-Table-Query-Private'
				with:
				[
					spec
						requires: #( 'RudesheimUtility' 'RudesheimKernel' )
				];

				package: 'Rudesheim-Table-Query'
				with:
				[
					spec
						requires: #( 'Rudesheim-Table-Query-Private' )
				];

				package: 'Rudesheim-Table-Query-InMemory-Private'
				with:
				[
					spec
						requires: #( 'Rudesheim-Table-Query-Private' )
				];

				package: 'Rudesheim-Table-Query-InMemory'
				with:
				[
					spec
						requires: #( 'Rudesheim-Table-Query' 'Rudesheim-Table-Query-InMemory-Private' )
				];

				package: 'Rudesheim-Table-Query-Private-Tests'
				with:
				[
					spec
						requires: #( 'Rudesheim-Table-Query' 'RudesheimUtilityTests' )
				];

				package: 'Rudesheim-Table-Query-Tests'
				with:
				[
					spec
						requires: #( 'Rudesheim-Table-Query-InMemory' 'RudesheimUtilityTests' )
				];

				package: 'Rudesheim-Table-Query-InMemory-Tests'
				with:
				[
					spec
						requires: #( 'Rudesheim-Table-Query-InMemory' 'Rudesheim-Table-Query-Tests' )
				];

				package: 'Rudesheim-Table-Query-SQL-Private'
				with:
				[
					spec
						requires: #( 'Rudesheim-Table-Query-Private' )
				];

				package: 'Rudesheim-Table-Query-SQL'
				with:
				[
					spec
						requires: #( 'Rudesheim-Table-Query' 'Rudesheim-Table-Query-SQL-Private' 'SQLite3' )
				];

				package: 'Rudesheim-Table-Query-SQL-Private-Tests'
				with:
				[
					spec
						requires: #( 'Rudesheim-Table-Query-SQL' 'Rudesheim-Table-Query-Tests' 'RudesheimUtilityTests' )
				];

				package: 'Rudesheim-Table-Query-SQL-Tests'
				with:
				[
					spec
						requires: #( 'Rudesheim-Table-Query-SQL' 'Rudesheim-Table-Query-SQL-Private-Tests' 'Rudesheim-Table-Query-Tests' )
				];

				group:		#core
				with:		#( 'Rudesheim-Table-Query' 'Rudesheim-Table-Query-InMemory' 'Rudesheim-Table-Query-SQL' );

				group:		#tests
				with:		#( 'Rudesheim-Table-Query-Tests' 'Rudesheim-Table-Query-InMemory-Tests' 'Rudesheim-Table-Query-SQL-Tests' );

				group:		#default
				with:		#( #core ).
		]
]
