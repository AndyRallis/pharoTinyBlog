Class {
	#name : #TBAuthenticationComponent,
	#superclass : #WAComponent,
	#instVars : [
		'password',
		'account',
		'component'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #'instance creation' }
TBAuthenticationComponent class >> from: aComponent [
	^ self new
		component: aComponent;
		yourself
]

{ #category : #accessing }
TBAuthenticationComponent >> account [
	^ account
]

{ #category : #accessing }
TBAuthenticationComponent >> account: anObject [
	account := anObject
]

{ #category : #accessing }
TBAuthenticationComponent >> component [ 
	^ component
]

{ #category : #accessing }
TBAuthenticationComponent >> component: anObject [
	component := anObject 
]

{ #category : #accessing }
TBAuthenticationComponent >> password [
	^ password
]

{ #category : #accessing }
TBAuthenticationComponent >> password: anObject [
	password := anObject
]

{ #category : #rendering }
TBAuthenticationComponent >> renderAccountFieldOn: html [
	html
		tbsFormGroup: [ html label with: 'Account'.
			html textInput
				tbsFormControl;
				attributeAt: 'autofocus' put: 'true';
				callback: [ :value | self account: value ];
				value: self account ]
]

{ #category : #rendering }
TBAuthenticationComponent >> renderBodyOn: html [
	html
		tbsModalBody: [ 
			html tbsForm: [ 
				self renderAccountFieldOn: html.
				self renderPasswordFieldOn: html.
				html tbsModalFooter: [ self renderButtonsOn: html ] ] ]
]

{ #category : #rendering }
TBAuthenticationComponent >> renderButtonsOn: html [
	html tbsButton
		attributeAt: 'type' put: 'button';
		attributeAt: 'data-dismiss' put: 'modal';
		beDefault;
		value: 'Cancel'.
	html tbsSubmitButton
		bePrimary;
		callback: [ self validate ];
		value: 'SignIn'
]

{ #category : #rendering }
TBAuthenticationComponent >> renderContentOn: html [
	html tbsModal
		id: 'myAuthDialog';
		with: [ html
				tbsModalDialog: [ html
						tbsModalContent: [ self renderHeaderOn: html.
							self renderBodyOn: html ] ] ]
]

{ #category : #rendering }
TBAuthenticationComponent >> renderHeaderOn: html [
	html
		tbsModalHeader: [ 
			html tbsModalCloseIcon.
			html tbsModalTitle
				level: 4;
				with: 'Authentication' ]
]

{ #category : #rendering }
TBAuthenticationComponent >> renderPasswordFieldOn: html [
	html tbsFormGroup: [ 
		html label with: 'Password'.
		html passwordInput
			tbsFormControl;
			callback: [ :value | self password: value ];
			value: self password ]
]

{ #category : #rendering }
TBAuthenticationComponent >> validate [
	^ self component tryConnectionWithLogin: self account andPassword: self password
]
