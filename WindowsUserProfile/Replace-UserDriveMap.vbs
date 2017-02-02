Set WshNetwork = WScript.CreateObject("WScript.Network")
Set oDrives = WshNetwork.EnumNetworkDrives
Set oPrinters = WshNetwork.EnumPrinterConnections

For i = 0 to oDrives.Count - 1 Step 2
    strDrive = oDrives.Item(i)
    strCurrentPath = LCase(oDrives.Item(i+1)) 'all the condition should be lower case

    If InStr(strCurrentPath, "fileservername") > 0 Then
        strNewPath = Replace( strCurrentPath,"\\fileservername\share$","\\contoso.net\newpath")

        result = MsgBox (strDrive & " " & strCurrentPath & " > " & strNewPath , vbYesNo, "Do you proceeed?")

        Select Case result
            Case vbYes
                ' Action when click Yes
                WshNetwork.RemoveNetworkDrive strDrive , True, True
                WScript.Sleep 1000 
                WshNetwork.MapNetworkDrive strDrive , strNewPath, True 

            Case vbNo
                ' Action when click No

        End Select
    End If
Next

MsgBox "Drivemap Replace Script Completed.",vbOKOnly,"Drivemap Replace Script"
