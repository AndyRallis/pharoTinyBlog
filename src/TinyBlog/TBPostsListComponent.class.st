Class {
	#name : #TBPostsListComponent,
	#superclass : #TBScreenComponent,
	#instVars : [
		'postComponents'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #rendering }
TBPostsListComponent >> children [ 
	^ self postComponents, super children
]

{ #category : #rendering }
TBPostsListComponent >> initialize [ 
	super initialize.
	postComponents := OrderedCollection new
]

{ #category : #rendering }
TBPostsListComponent >> postComponents [
	postComponents := self readSelectedPosts
		collect: [ :each | TBPostComponent new post: each ].
	^ postComponents 
]

{ #category : #rendering }
TBPostsListComponent >> readSelectedPosts [
	^ self blog allVisibleBlogPosts 
]

{ #category : #rendering }
TBPostsListComponent >> renderContentOn: html [
	super renderContentOn: html.
	html tbsContainer: [ 
		self postComponents do: [ :p | 
		html render:  p ] ]
]
