''Fax C&I Applications via RightFax
''Created by: Zachary Karpinski
''Purpose: Automate faxing of C&I applications with RightFax
''Reference: http://saltwetbytes.wordpress.com/2010/06/30/rightfax-com-api-using-vbscript/

''Requirements:
''  rfcomapi.dll (RightFax COM)
''  Microsoft Office 2003+

'Constants
Const msoFileDialogOpen = 1
Const SERVER_NAME = "SERVER_NAME"
Const USER_ID = "USER_ID"


Set faxAPI = CreateObject("RFCOMAPI.FaxServer")

'Connect to RightFax
faxAPI.servername = SERVER_NAME
faxAPI.UseNTAuthentication = False
faxAPI.AuthorizationUserID = USER_ID
'faxAPI.AuthorizationUserPassword = "YOUR PASSWORD"
'Set protocol
faxAPI.Protocol = 4 '4 = tcp, 1 = name pipes

'**Create word instance and use fileopen dialog
Set objWord = CreateObject("Word.Application")
objWord.WindowState = 2 'hide word
Set fd = objWord.FileDialog(msoFileDialogOpen)
With fd
   .AllowMultiSelect = True
   .Title = "Select files to Fax"
    'When user clicks open        
    if .Show = -1 Then
        For Each sFile in .SelectedItems
            'Create new fax object
            Set newFax = faxAPI.CreateObject(5)
            'Enter Fax Details
            newFax.ToFaxNumber = "88888888888"
            newFax.ToName = "NAME_HERE"
            newFax.HasCoversheet = True
            newFax.Attachments.Add sFile, False 'Don't delete file after
            'Send Fax
            newFax.Send
            'Wait then clear object and continue
            WScript.Sleep 100
            Set newFax = Nothing
        Next
    End If
End With

'Release objects
Set fd = Nothing
objWord.Quit
Set objWord = Nothing