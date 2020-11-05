Class {
	#name : #TBPostsListComponent,
	#superclass : #TBScreenComponent,
	#instVars : [
		'postComponents',
		'currentCategory',
		'categoryComponent'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #accessing }
TBPostsListComponent >> categoryComponent [
	categoryComponent := TBCategoriesComponent
						categories: (self blog allCategories)
						postsList: self.
	^ categoryComponent 
]

{ #category : #initialization }
TBPostsListComponent >> children [ 
	^ self postComponents, { self categoryComponent }, super children
]

{ #category : #accessing }
TBPostsListComponent >> currentCategory [
	^ currentCategory
]

{ #category : #accessing }
TBPostsListComponent >> currentCategory: anObject [
	currentCategory := anObject
]

{ #category : #'as yet unclassified' }
TBPostsListComponent >> goToAdministrationView [
	self call: TBAdminComponent new
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
	^ self currentCategory 
		ifNil: [ self blog allVisibleBlogPosts ]
		ifNotNil: [ self blog allVisibleBlogPostsFromCategory: 
			self currentCategory ]
]

{ #category : #rendering }
TBPostsListComponent >> renderCategoryColumnOn: html [ 
	html tbsColumn 
		extraSmallSize: 12;
		smallSize: 2;
		mediumSize: 4;
		with: self categoryComponent
]

{ #category : #rendering }
TBPostsListComponent >> renderContentOn: html [
	super renderContentOn: html.
	html tbsContainer: [ 
		html tbsRow showGrid;
			with: [ 
				self renderCategoryColumnOn: html.
				self renderPostColumnOn: html ] ]
]

{ #category : #rendering }
TBPostsListComponent >> renderPostColumnOn: html [ 
	html tbsColumn 
		extraSmallSize: 12;
		smallSize: 10;
		mediumSize: 8;
		with: [ self postComponents do: [ :p | html render: p ] ]
]
