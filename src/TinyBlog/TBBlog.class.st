"
I am a Tiny Blog engine. I hold Tiny Blog Posts and manage the collection of posts as well as filtering by category and visibility. 

Public API:
	- allBlogPosts returns everything
	- allBlogPostsFromCategory: takes a category and filters 
	- allCategories lists out the categories in the blog
	- allVisibleBlogPosts returns only posts which are visible 
	- allVisibleBlogPostsFromCategory: returns visible posts in a category 
	- removeAllPosts refreshes the entire blog
"
Class {
	#name : #TBBlog,
	#superclass : #Object,
	#instVars : [
		'adminUser',
		'posts'
	],
	#category : #'TinyBlog-Model'
}

{ #category : #prototypes }
TBBlog class >> createDemoPosts [
	"TBBlog createDemoPosts" 
	self current
		writeBlogPost: ((TBPost title: 'Welcome in TinyBlog' text: 'TinyBlog is a small blog engine 								made with Pharo.' category: 'TinyBlog') visible: true);
		writeBlogPost: ((TBPost title: 'Report Pharo Sprint' text: 'Friday, June 12 there was a Pharo 								sprint / Moose dojo. It nice event with more than 15 motivated sprinters. With 								the of candies, cakes and chocolate, huge work has been done' category: 								'Pharo') visible: true);
		writeBlogPost: ((TBPost title: 'Brick on top of Bloc - Preview' text: 'We are happy to announce 								the first preview version of Brick, a new widget set created from scratch on 								top of Bloc. Brick is being developed primarily by Alex Syrel (together with 								Alain Plantec, Andrei Chis and myself), and the work is sponsored by ESUG.
								Brick is part of the Glamorous Toolkit effort and will provide the basis for 								the new versions of the development tools.' category: 'Pharo') visible: true);
		writeBlogPost: ((TBPost title: 'The sad story of unclassified blog posts' text: 'So sad that I 								can read this.') visible: true);
		writeBlogPost: ((TBPost title: 'Working with Pharo on the Raspberry Pi' text: 'Hardware is 								getting cheaper and many new small devices like the famous Raspberry Pi 								provide new computation power that was one once only available on regular 								desktop computers.' category: 'Pharo') visible: true)
]

{ #category : #initialization }
TBBlog class >> current [  
	"send the instance of the TB repository"
	^ self selectAll
		ifNotEmpty: [ :x | x anyOne ]
		ifEmpty: [ self new save ]
]

{ #category : #accessing }
TBBlog class >> defaultAdminLogin [
	^ 'admin'
]

{ #category : #accessing }
TBBlog class >> defaultAdminPassword [
	^ 'topsecret'
]

{ #category : #initialization }
TBBlog class >> initialize [ 
	self reset
]

{ #category : #initialization }
TBBlog class >> initializeLocalhostMongoDB [
	| repository |
	repository := VOMongoRepository database: 'tinyblog'.
	repository enableSingleton 
]

{ #category : #initialization }
TBBlog class >> initializeVoyageOnMemoryDB [
	VOMemoryRepository new enableSingleton
]

{ #category : #'voyage-root' }
TBBlog class >> isVoyageRoot [
	"Indicates that instances of this class are top level documents in noSQL databases"
	^ true
]

{ #category : #initialization }
TBBlog class >> reset [ 
	self initializeVoyageOnMemoryDB  
]

{ #category : #accessing }
TBBlog >> administrator [
	^ adminUser 
]

{ #category : #rolling }
TBBlog >> allBlogPosts [
	^ posts
]

{ #category : #accessing }
TBBlog >> allBlogPostsFromCategory: aCategory [ 
	^ posts select: [ :p | p category = aCategory ]
]

{ #category : #categories }
TBBlog >> allCategories [
	^ (self allBlogPosts collect: [ :p | p category ]) asSet addAllCategory
]

{ #category : #accessing }
TBBlog >> allCategoriesWithVisiblePost [
	^ ((posts select: [ :p | p isVisible ]) collect: [ :p | p category ]) asSet
]

{ #category : #accessing }
TBBlog >> allVisibleBlogPosts [
	^ posts select: [ :post | post isVisible ]
]

{ #category : #accessing }
TBBlog >> allVisibleBlogPostsFromCategory: aCategory [
	(aCategory = 'All') 
		ifTrue: [ ^ self allVisibleBlogPosts ]
		ifFalse: [ ^ posts select: [ :p | p category = aCategory and: [ p isVisible  ] ] ]
]

{ #category : #administration }
TBBlog >> createAdministrator [
	^ TBAdministrator
		login: self class defaultAdminLogin
		password: self class defaultAdminPassword
]

{ #category : #initialization }
TBBlog >> initialize [
	super initialize.
	posts := OrderedCollection new.
	adminUser := self createAdministrator
]

{ #category : #'post-management' }
TBBlog >> removeAllPosts [
	posts := OrderedCollection new.
	self save
]

{ #category : #removing }
TBBlog >> removeBlogPost: aPost [
	posts remove: aPost ifAbsent: [ ].
	self save
]

{ #category : #'blog-management' }
TBBlog >> renameCategory: aCategoryStart to: aCategorySecond [ 
	| f s |
	f := posts select: [ :p | p category = aCategoryStart ].
	s := f size.
	(s = 0) ifTrue: [ ^ false ].
	f do: [ :each | each category: aCategorySecond ].
	^ true
]

{ #category : #accessing }
TBBlog >> size [
	^ posts size
]

{ #category : #'post-creation' }
TBBlog >> writeBlogPost: aTBPost [ 
	"Add blog post to list of blog posts"
	self allBlogPosts add: aTBPost.
	self save
]
