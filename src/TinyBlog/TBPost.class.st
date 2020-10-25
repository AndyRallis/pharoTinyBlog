"
I am a Tiny Blog Post and contain date, text, title, category and visibility status. I should probably be contained inside a Tiny Blog. I should also probably have an author
"
Class {
	#name : #TBPost,
	#superclass : #Object,
	#instVars : [
		'title',
		'text',
		'date',
		'category',
		'visible'
	],
	#category : #'TinyBlog-Model'
}

{ #category : #'creation - post' }
TBPost class >> title: aTitle text: aText [
	^ self new 
		title: aTitle;
		text: aText
]

{ #category : #'creation - post' }
TBPost class >> title: aTitle text: aText category: aCategory [
	^ (self title: aTitle text: aText)
		category: aCategory
]

{ #category : #'creation - post' }
TBPost class >> unclassifiedTag [
	^ 'Unclassified'
]

{ #category : #actions }
TBPost >> beVisible [
	self visible: true
]

{ #category : #accessing }
TBPost >> category [
	^ category
]

{ #category : #accessing }
TBPost >> category: anObject [
	category := anObject
]

{ #category : #accessing }
TBPost >> date [
	^ date
]

{ #category : #accessing }
TBPost >> date: anObject [
	date := anObject
]

{ #category : #accessing }
TBPost >> initialize [
	super initialize.
	self category: self class unclassifiedTag.
	self date: Date today.
	self notVisible
]

{ #category : #testing }
TBPost >> isUnclassified [ 
	^ self category = self class unclassifiedTag  
]

{ #category : #testing }
TBPost >> isVisible [
	^ self visible
]

{ #category : #actions }
TBPost >> notVisible [
	self visible: false
]

{ #category : #accessing }
TBPost >> text [
	^ text
]

{ #category : #accessing }
TBPost >> text: anObject [
	text := anObject
]

{ #category : #accessing }
TBPost >> title [
	^ title
]

{ #category : #accessing }
TBPost >> title: anObject [
	title := anObject
]

{ #category : #accessing }
TBPost >> visible [
	^ visible
]

{ #category : #accessing }
TBPost >> visible: anObject [
	visible := anObject
]
