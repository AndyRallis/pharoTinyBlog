Extension { #name : #Set }

{ #category : #'*TinyBlog-Model' }
Set >> addAllCategory [
	self addCategory: 'All'
]

{ #category : #'*TinyBlog-Model' }
Set >> addCategory: aCategory [ 
	self add: aCategory
]
