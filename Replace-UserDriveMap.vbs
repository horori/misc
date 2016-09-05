Set WshNetwork = WScript.CreateObject("WScript.Network")
Set oDrives = WshNetwork.EnumNetworkDrives
Set oPrinters = WshNetwork.EnumPrinterConnections

For i = 0 to oDrives.Count - 1 Step 2
    strDrive = oDrives.Item(i)
    strCurrentPath = oDrives.Item(i+1)

    If InStr(strCurrentPath, "fileservername") > 0 Then
        strNewPath = Replace( strCurrentPath, "\\fileservername\share$", "\\contoso.net\ABCDEF")
        result = MsgBox (strDrive & " " & strCurrentPath & " > " & strNewPath , vbYesNo, "Do you proceeed?")

        Select Case result
            Case vbYes
                ' Action when click Yes
                objNetwork.MapNetworkDrive strDriv , strNewPath, True

            Case vbNo
                ' Action when click No

        End Select
    End If
Next
