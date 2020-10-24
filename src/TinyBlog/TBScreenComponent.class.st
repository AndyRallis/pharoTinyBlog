Class {
	#name : #TBScreenComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #'accessing - model' }
TBScreenComponent >> blog [
	^ TBBlog current
]

{ #category : #initialization }
TBScreenComponent >> children [
	^ { header }
]

{ #category : #initialization }
TBScreenComponent >> createHeaderComponent [
	^ TBHeaderComponent new
]

{ #category : #initialization }
TBScreenComponent >> initialize [ 
	super initialize.
	header := self createHeaderComponent
]

{ #category : #rendering }
TBScreenComponent >> renderContentOn: html [ 
	html render: header
]
