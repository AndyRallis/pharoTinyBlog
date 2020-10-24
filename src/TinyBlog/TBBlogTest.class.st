Class {
	#name : #TBBlogTest,
	#superclass : #TestCase,
	#instVars : [
		'blog',
		'post',
		'first',
		'previousRepository'
	],
	#category : #'TinyBlog-Tests'
}

{ #category : #running }
TBBlogTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	previousRepository := VORepository current.
	VORepository setRepository: VOMemoryRepository new.
 	blog := TBBlog current.
	blog removeAllPosts.
	
	first := TBPost title: 'A title' text: 'A text' category: 'First Category'.
	blog writeBlogPost: first.
	
	post := (TBPost title: 'Another title' text: 'Another text' category: 'Second Category') beVisible
]

{ #category : #running }
TBBlogTest >> tearDown [ 
	VORepository setRepository: previousRepository
]

{ #category : #tests }
TBBlogTest >> testAddBlogPost [
	blog writeBlogPost: post.
	self assert: blog size equals: 2
]

{ #category : #tests }
TBBlogTest >> testAllBlogPosts [
	blog writeBlogPost: post.
	self assert: blog allBlogPosts size equals: 2
]

{ #category : #tests }
TBBlogTest >> testAllBlogPostsFromCategory [
	self assert: (blog allBlogPostsFromCategory: 'First Category') size equals: 1
]

{ #category : #tests }
TBBlogTest >> testAllCategories [
	blog writeBlogPost: post.
	self assert: blog allCategories size equals: 2
]

{ #category : #tests }
TBBlogTest >> testAllCategoriesWithVisiblePost [
	blog writeBlogPost: post.
	self assert: (blog allCategoriesWithVisiblePost) size equals: 1
]

{ #category : #tests }
TBBlogTest >> testAllVisibleBlogPosts [
	blog writeBlogPost: post.
	self assert: blog allVisibleBlogPosts size equals: 1
]

{ #category : #tests }
TBBlogTest >> testAllVisibleBlogPostsFromCategory [
	blog writeBlogPost: post.
	self assert: (blog allVisibleBlogPostsFromCategory: 'First Category') size equals: 0.
	self assert: (blog allVisibleBlogPostsFromCategory: 'Second Category') size equals: 1
]

{ #category : #tests }
TBBlogTest >> testRemoveAllPosts [
	blog removeAllPosts.
	self assert: blog size equals: 0
]

{ #category : #tests }
TBBlogTest >> testRenameCategoryTo [
	self assert: (blog renameCategory: 'Second Category' to: 'Category Two') equals: false.
	blog writeBlogPost: post.
	self assert: (blog renameCategory: 'Second Category' to: 'Category Two') equals: true.
	self assert: (blog allCategories includes: 'Category Two') equals: true	
]

{ #category : #tests }
TBBlogTest >> testSize [
	self assert: blog size equals: 1
]

{ #category : #tests }
TBBlogTest >> testUnclassifiedBlogPosts [
	self assert: (blog allBlogPosts select: [ :p | p isUnclassified ] ) size equals: 0
]
