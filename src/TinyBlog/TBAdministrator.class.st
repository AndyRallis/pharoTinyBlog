Class {
	#name : #TBAdministrator,
	#superclass : #Object,
	#instVars : [
		'login',
		'password'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #administration }
TBAdministrator class >> login: aLogin password: aPassword [
	^ self new 
		login: aLogin;
		password: aPassword;
		yourself
]

{ #category : #accessing }
TBAdministrator >> login [
	^ login
]

{ #category : #accessing }
TBAdministrator >> login: anObject [
	login := anObject
]

{ #category : #accessing }
TBAdministrator >> password [
	^ password
]

{ #category : #accessing }
TBAdministrator >> password: anObject [
	password := SHA256 hashMessage: anObject
]
