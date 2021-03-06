; // Hotkey for Add Customer Contact(With Parameters)
; // Created by: Zachary Karpinski
; // Last Modified: 01/16/15

; // usage: Autohotkey http://www.autohotkey.com/
; //	Enter account number, run script then make the CSS window active

; // Exit Codes:
; // 0 Manually Exited
; // 100 Full Success

; // Read Parameters http://www.autohotkey.com/board/topic/6953-processing-command-line-parameters/
Loop, %0% {
    If (%A_Index% = "/account")	{ 
        AccNum := A_Index + 1
		AccNum := %AccNum%
		}
    Else If (%A_Index% = "/contact") {
        Contact := A_Index + 1
		Contact := %Contact%
		}
	Else If (%A_Index% = "/type") {
        ContactType := A_Index + 1
		ContactType := %ContactType%
		}
  }

; // Wait until CSS is loaded.
WinWait, Customer Service System Retrieval
WinActivate, Customer Service System Retrieval

; // Clear retriveval
Send, {ALT down}
Sleep, 50
Send, d
Sleep, 100
Send {ALT up}

; // Add Account number
Send {TAB 4}
Sleep, 250
Send, %AccNum%

; // Find Account number
Sleep, 250
Send, {ENTER}
Sleep, 800

IfWinExist, Premise For
{
	WinWait, Account %AccNum% for
}

; // Wait for Account (2 Minutes)
WinWait, Account %AccNum% for,, 120
if ErrorLevel
{
	MsgBox, Waiting for contact window timed out.
	Exit 1
}
else{}
Sleep, 100

; // Skip Critcal Contact message.
Send, o
Sleep, 100
Send, o
Sleep, 100

; // Open Contact Window
Send, {ALT}
Sleep, 250
Send, a
Sleep, 100
Send, a
Sleep, 100
Send, c
Sleep, 100
Send, a

; // Wait for add account contact window (1 minute)
WinWait, Add Account Contact for %AccNum%,, 60
if ErrorLevel
{
	MsgBox, Waiting for contact window timed out.
	Exit 2
}
Sleep, 100

; // Select Contact Type
Send, {TAB 8}
Sleep, 100
Send, %ContactType%
Sleep, 200

; //Enter Contact
Send, {TAB}
Sleep, 100
Send, %Contact%
Sleep, 200

; //Process
Send, {ALT}
Sleep, 100
Send, c
Sleep, 100
Send, p
; // Wait for confirmation window (20 seconds)
WinWait, Customer Service System (PRODUCTION),, 20
if ErrorLevel
{
	MsgBox, Processing contact timed out.
	Exit 3
}
Sleep, 50
Send, o
Sleep, 200

; // Exit Account
WinActivate, Account %AccNum% for
Sleep, 200
Send, {ALT}
Sleep, 100
Send, c
Sleep, 100
Send, e
Sleep 300

IfWinExist, Account %AccNum% for
{
	WinActivate, Account %AccNum% for
	; // Exit Account
	Send, {ALT}
	Sleep, 100
	Send, c
	Sleep, 100
	Send, e
	Sleep 300
}

ExitApp 100

