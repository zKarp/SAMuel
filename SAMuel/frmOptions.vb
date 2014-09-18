﻿Imports System.IO

Public Class frmOptions

    Private Sub btnSelectSaveFolder_Click(sender As Object, e As EventArgs) Handles btnSelectSaveFolder.Click
        If FolderBrowserDialog1.ShowDialog() = DialogResult.OK Then
            Me.txtSavePath.Text = FolderBrowserDialog1.SelectedPath + "\"
        End If
    End Sub

    Private Sub btnSaveOptions_Click(sender As Object, e As EventArgs) Handles btnSaveOptions.Click
        'Update settings, save and close
        If Me.txtSavePath.Text <> My.Settings.savePath Then
            My.Settings.savePath = Me.txtSavePath.Text
            My.Settings.Save()
            GlobalModule.LogAction(actionCode:=2, action:=Me.txtSavePath.Text)
            GlobalModule.InitOutputFolders()
        End If

        Select Case cmbColorDepth.SelectedItem.ToString
            Case "1-bit"
                My.Settings.colorDepth = 1L
            Case "2-bit"
                My.Settings.colorDepth = 2L
            Case "8-bit"
                My.Settings.colorDepth = 8L
            Case "24-bit"
                My.Settings.colorDepth = 24L
            Case "30-bit"
                My.Settings.colorDepth = 30L
        End Select

        My.Settings.tiffCompression = cmbCompression.SelectedItem.ToString
        My.Settings.wmFont = cmbFont.SelectedItem.ToString
        My.Settings.Save()

        Me.Close()
    End Sub

    Private Sub frmOptions_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Me.txtSavePath.Text = My.Settings.savePath
        Me.cmbColorDepth.SelectedItem = My.Settings.colorDepth.ToString & "-bit"
        Me.cmbCompression.SelectedItem = My.Settings.tiffCompression
        Me.cmbFont.SelectedItem = My.Settings.wmFont
    End Sub

    Private Sub btnEmpty_Click(sender As Object, e As EventArgs) Handles btnEmpty.Click

        If (Directory.Exists(My.Settings.savePath + "tiffs\")) Then Directory.Delete(My.Settings.savePath + "tiffs\", True)
        If (Directory.Exists(My.Settings.savePath + "faxed\")) Then Directory.Delete(My.Settings.savePath + "faxed\", True)
        If (Directory.Exists(My.Settings.savePath + "converted\")) Then Directory.Delete(My.Settings.savePath + "converted\", True)
        If (Directory.Exists(My.Settings.savePath + "emails\")) Then Directory.Delete(My.Settings.savePath + "emails\", True)
        MsgBox("SAMuel save folder cleared!", MsgBoxStyle.OkOnly)
    End Sub

    Private Sub btnViewLog_Click(sender As Object, e As EventArgs) Handles btnViewLog.Click
        If (File.Exists(My.Settings.savePath + "SAMuel.log")) Then System.Diagnostics.Process.Start(My.Settings.savePath + "SAMuel.log")
    End Sub

    Private Sub btnShow_Click(sender As Object, e As EventArgs) Handles btnShow.Click
        'Open the saved path folder with windows explorer.
        Process.Start("explorer.exe", My.Settings.savePath)
    End Sub
End Class