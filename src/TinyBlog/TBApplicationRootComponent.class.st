Class {
	#name : #TBApplicationRootComponent,
	#superclass : #WAComponent,
	#instVars : [
		'main'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #testing }
TBApplicationRootComponent class >> canBeRoot [
	^ true
]

{ #category : #'class initialization' }
TBApplicationRootComponent class >> initialize [ 
	| app |
	app := WAAdmin register: self asApplicationAt: 'TinyBlog'.
	app
		addLibrary: JQDeploymentLibrary;
		addLibrary: JQUiDeploymentLibrary;
		addLibrary: TBSDeploymentLibrary.
]

{ #category : #hooks }
TBApplicationRootComponent >> children [ 
	^ { main }
]

{ #category : #initialization }
TBApplicationRootComponent >> initialize [ 
	super initialize.
	main := TBPostsListComponent new
]

{ #category : #initialization }
TBApplicationRootComponent >> main: aComponent [
	main := aComponent
]

{ #category : #rendering }
TBApplicationRootComponent >> renderContentOn: html [ 
	html render: main
]

{ #category : #rendering }
TBApplicationRootComponent >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot title: 'TinyBlog'
]