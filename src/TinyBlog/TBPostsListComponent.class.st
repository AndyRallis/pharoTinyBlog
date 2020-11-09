Class {
	#name : #TBPostsListComponent,
	#superclass : #TBScreenComponent,
	#instVars : [
		'postComponents',
		'currentCategory',
		'categoryComponent',
		'showLoginError'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #rendering }
TBPostsListComponent >> basicRenderPostsOn: html [
	self postComponents do: [ :p | html render: p ]
]

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

{ #category : #administration }
TBPostsListComponent >> goToAdministrationView [
	self call: TBAdminComponent new
]

{ #category : #testing }
TBPostsListComponent >> hasLoginError [
	^ showLoginError ifNil: [ false ]
]

{ #category : #rendering }
TBPostsListComponent >> initialize [ 
	super initialize.
	postComponents := OrderedCollection new
]

{ #category : #'error handing' }
TBPostsListComponent >> loginErrorMessage [
	^ 'Incorrect login and/or password'
]

{ #category : #'error handing' }
TBPostsListComponent >> loginErrorOccurred [
	showLoginError := true
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
TBPostsListComponent >> renderLoginErrorMessageIfAnyOn: html [
	self hasLoginError
		ifTrue: [ showLoginError := false.
			html
				tbsAlert
				beDanger;
				with: self loginErrorMessage ]
]

{ #category : #rendering }
TBPostsListComponent >> renderPostColumnOn: html [ 
	html tbsColumn 
		extraSmallSize: 12;
		smallSize: 10;
		mediumSize: 8;
		with: [ 
			self renderLoginErrorMessageIfAnyOn: html.
			self basicRenderPostsOn: html]
]

{ #category : #authentication }
TBPostsListComponent >> tryConnectionWithLogin: aLogin andPassword: aPassword [
	(aLogin = self blog administrator login
		and: [ (SHA256 hashMessage: aPassword) = self blog administrator password ])
		ifTrue: [
			self session currentAdmin: self blog administrator.
			self goToAdministrationView ]
		ifFalse: [ self loginErrorOccurred ]
]
