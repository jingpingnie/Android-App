' Windows Installer utility to applay a transform to an installer database
' For use with Windows Scripting Host, CScript.exe or WScript.exe
' Copyright (c) Microsoft Corporation. All rights reserved.
' Demonstrates use of Database.ApplyTransform and MsiDatabaseApplyTransform
'
Option Explicit

' Error conditions that may be suppressed when applying transforms
Const msiTransformErrorAddExistingRow         = 1 'Adding a row that already exists. 
Const msiTransformErrorDeleteNonExistingRow   = 2 'Deleting a row that doesn't exist. 
Const msiTransformErrorAddExistingTable       = 4 'Adding a table that already exists. 
Const msiTransformErrorDeleteNonExistingTable = 8 'Deleting a table that doesn't exist. 
Const msiTransformErrorUpdateNonExistingRow  = 16 'Updating a row that doesn't exist. 
Const msiTransformErrorChangeCodePage       = 256 'Transform and database code pages do not match 

Const msiOpenDatabaseModeReadOnly     = 0
Const msiOpenDatabaseModeTransact     = 1
Const msiOpenDatabaseModeCreate       = 3

If (Wscript.Arguments.Count < 2) Then
	Wscript.Echo "Windows Installer database tranform application utility" &_
		vbNewLine & " 1st argument is the path to an installer database" &_
		vbNewLine & " 2nd argument is the path to the transform file to apply" &_
		vbNewLine & " 3rd argument is optional set of error conditions to suppress:" &_
		vbNewLine & "     1 = adding a row that already exists" &_
		vbNewLine & "     2 = deleting a row that doesn't exist" &_
		vbNewLine & "     4 = adding a table that already exists" &_
		vbNewLine & "     8 = deleting a table that doesn't exist" &_
		vbNewLine & "    16 = updating a row that doesn't exist" &_
		vbNewLine & "   256 = mismatch of database and transform codepages" &_
		vbNewLine &_
		vbNewLine & "Copyright (C) Microsoft Corporation.  All rights reserved."
	Wscript.Quit 1
End If

' Connect to Windows Installer object
On Error Resume Next
Dim installer : Set installer = Nothing
Set installer = Wscript.CreateObject("WindowsInstaller.Installer") : CheckError

' Open database and apply transform
Dim database : Set database = installer.OpenDatabase(Wscript.Arguments(0), msiOpenDatabaseModeTransact) : CheckError
Dim errorConditions:errorConditions = 0
If Wscript.Arguments.Count >= 3 Then errorConditions = CLng(Wscript.Arguments(2))
Database.ApplyTransform Wscript.Arguments(1), errorConditions : CheckError
Database.Commit : CheckError

Sub CheckError
	Dim message, errRec
	If Err = 0 Then Exit Sub
	message = Err.Source & " " & Hex(Err) & ": " & Err.Description
	If Not installer Is Nothing Then
		Set errRec = installer.LastErrorRecord
		If Not errRec Is Nothing Then message = message & vbNewLine & errRec.FormatText
	End If
	Wscript.Echo message
	Wscript.Quit 2
End Sub

'' SIG '' Begin signature block
'' SIG '' MIIirQYJKoZIhvcNAQcCoIIinjCCIpoCAQExDzANBglg
'' SIG '' hkgBZQMEAgEFADB3BgorBgEEAYI3AgEEoGkwZzAyBgor
'' SIG '' BgEEAYI3AgEeMCQCAQEEEE7wKRaZJ7VNj+Ws4Q8X66sC
'' SIG '' AQACAQACAQACAQACAQAwMTANBglghkgBZQMEAgEFAAQg
'' SIG '' ocXRzPIBsTOs40BugTYvo1tESbFrFB3U6AbYVQhStNmg
'' SIG '' gguBMIIFCTCCA/GgAwIBAgITMwAAAiRtkuVYynX+eAAA
'' SIG '' AAACJDANBgkqhkiG9w0BAQsFADB+MQswCQYDVQQGEwJV
'' SIG '' UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
'' SIG '' UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
'' SIG '' cmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQgQ29kZSBT
'' SIG '' aWduaW5nIFBDQSAyMDEwMB4XDTE4MDUzMTE3MzcwMloX
'' SIG '' DTE5MDUyOTE3MzcwMlowfzELMAkGA1UEBhMCVVMxEzAR
'' SIG '' BgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
'' SIG '' bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
'' SIG '' bjEpMCcGA1UEAxMgTWljcm9zb2Z0IFdpbmRvd3MgS2l0
'' SIG '' cyBQdWJsaXNoZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IB
'' SIG '' DwAwggEKAoIBAQC1ADtV5WbtbteGtgU9cNUX+b0OGB/W
'' SIG '' JCQMdiliySB/iACnI6QBanWCXt2GKq/H1dU4weRkdFJD
'' SIG '' QNd89v4hppxxFFeZpmhVfQapRAJf7giq9ke3HOjj8J7v
'' SIG '' jruaSdUERWdrpPmTI4D2RD8aSIrVd/K3gsIMUEW8mQjU
'' SIG '' f44qK7H7B9ZJs494Ua0c8Fs7gMbsGW+6+wDpMYAdeei2
'' SIG '' E4k2GOwhTEZwEnFawKbNg6mNyYiP5M5aFL+YECsKdaF3
'' SIG '' 136fer6lnaSjZVmtvlXy8Y+ARevpAtaNA5GWBZeDBP9h
'' SIG '' d/F7sPelxRghJlxoheacIx60A4IPxR2yAAVfmaUoHTw9
'' SIG '' KS7ZAgMBAAGjggF9MIIBeTAfBgNVHSUEGDAWBgorBgEE
'' SIG '' AYI3CgMUBggrBgEFBQcDAzAdBgNVHQ4EFgQU9N7wcxha
'' SIG '' V2r8PhDt3mJo/Q620powVAYDVR0RBE0wS6RJMEcxLTAr
'' SIG '' BgNVBAsTJE1pY3Jvc29mdCBJcmVsYW5kIE9wZXJhdGlv
'' SIG '' bnMgTGltaXRlZDEWMBQGA1UEBRMNMjI5OTAzKzQzNjA4
'' SIG '' OTAfBgNVHSMEGDAWgBTm/F97uyIAWORyTrX0IXQjMubv
'' SIG '' rDBWBgNVHR8ETzBNMEugSaBHhkVodHRwOi8vY3JsLm1p
'' SIG '' Y3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWND
'' SIG '' b2RTaWdQQ0FfMjAxMC0wNy0wNi5jcmwwWgYIKwYBBQUH
'' SIG '' AQEETjBMMEoGCCsGAQUFBzAChj5odHRwOi8vd3d3Lm1p
'' SIG '' Y3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY0NvZFNpZ1BD
'' SIG '' QV8yMDEwLTA3LTA2LmNydDAMBgNVHRMBAf8EAjAAMA0G
'' SIG '' CSqGSIb3DQEBCwUAA4IBAQDkadQCXIoOfikTJJIeXscy
'' SIG '' BXfju3HHVX+X4KZs2VaywFNnDCIJG419qelfMGwzOS2N
'' SIG '' v1ajauk8Jfz3Sg3/BGACMW2fid9gBczR/7IAXJHtKgxk
'' SIG '' NB0/t0YH10ep/6lkK0nM/8O9HWoV/c7i4LdIfTieF7MD
'' SIG '' AUrpMkwVX0AEWk38tz497QVPkDwR7Ugw2AOS5qnRiwev
'' SIG '' CvAk67mtKYPKd1MdVu06e3dF/iglNZuvBWIeKFaz0du0
'' SIG '' sBhXrmpO/rix/C1e1Tpg+dpv8t131u/rIzaFQYsdbNaS
'' SIG '' Z7NfbUXotR2wnWlgBr8O8uT3sdpvekrlTZ2JA0umPZXw
'' SIG '' oZehh4icZ90NMIIGcDCCBFigAwIBAgIKYQxSTAAAAAAA
'' SIG '' AzANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMx
'' SIG '' EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1Jl
'' SIG '' ZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
'' SIG '' dGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2Vy
'' SIG '' dGlmaWNhdGUgQXV0aG9yaXR5IDIwMTAwHhcNMTAwNzA2
'' SIG '' MjA0MDE3WhcNMjUwNzA2MjA1MDE3WjB+MQswCQYDVQQG
'' SIG '' EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
'' SIG '' BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
'' SIG '' cnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQgQ29k
'' SIG '' ZSBTaWduaW5nIFBDQSAyMDEwMIIBIjANBgkqhkiG9w0B
'' SIG '' AQEFAAOCAQ8AMIIBCgKCAQEA6Q5kUHlntcTj/QkATJ6U
'' SIG '' rPdWaOpE2M/FWE+ppXZ8bUW60zmStKQe+fllguQX0o/9
'' SIG '' RJwI6GWTzixVhL99COMuK6hBKxi3oktuSUxrFQfe0dLC
'' SIG '' iR5xlM21f0u0rwjYzIjWaxeUOpPOJj/s5v40mFfVHV1J
'' SIG '' 9rIqLtWFu1k/+JC0K4N0yiuzO0bj8EZJwRdmVMkcvR3E
'' SIG '' VWJXcvhnuSUgNN5dpqWVXqsogM3Vsp7lA7Vj07IUyMHI
'' SIG '' iiYKWX8H7P8O7YASNUwSpr5SW/Wm2uCLC0h31oVH1RC5
'' SIG '' xuiq7otqLQVcYMa0KlucIxxfReMaFB5vN8sZM4BqiU2j
'' SIG '' amZjeJPVMM+VHwIDAQABo4IB4zCCAd8wEAYJKwYBBAGC
'' SIG '' NxUBBAMCAQAwHQYDVR0OBBYEFOb8X3u7IgBY5HJOtfQh
'' SIG '' dCMy5u+sMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBB
'' SIG '' MAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8G
'' SIG '' A1UdIwQYMBaAFNX2VsuP6KJcYmjRPZSQW9fOmhjEMFYG
'' SIG '' A1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwubWljcm9z
'' SIG '' b2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0Nl
'' SIG '' ckF1dF8yMDEwLTA2LTIzLmNybDBaBggrBgEFBQcBAQRO
'' SIG '' MEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93d3cubWljcm9z
'' SIG '' b2Z0LmNvbS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIw
'' SIG '' MTAtMDYtMjMuY3J0MIGdBgNVHSAEgZUwgZIwgY8GCSsG
'' SIG '' AQQBgjcuAzCBgTA9BggrBgEFBQcCARYxaHR0cDovL3d3
'' SIG '' dy5taWNyb3NvZnQuY29tL1BLSS9kb2NzL0NQUy9kZWZh
'' SIG '' dWx0Lmh0bTBABggrBgEFBQcCAjA0HjIgHQBMAGUAZwBh
'' SIG '' AGwAXwBQAG8AbABpAGMAeQBfAFMAdABhAHQAZQBtAGUA
'' SIG '' bgB0AC4gHTANBgkqhkiG9w0BAQsFAAOCAgEAGnTvV08p
'' SIG '' e8QWhXi4UNMi/AmdrIKX+DT/KiyXlRLl5L/Pv5PI4zSp
'' SIG '' 24G43B4AvtI1b6/lf3mVd+UC1PHr2M1OHhthosJaIxrw
'' SIG '' jKhiUUVnCOM/PB6T+DCFF8g5QKbXDrMhKeWloWmMIpPM
'' SIG '' dJjnoUdD8lOswA8waX/+0iUgbW9h098H1dlyACxphnY9
'' SIG '' UdumOUjJN2FtB91TGcun1mHCv+KDqw/ga5uV1n0oUbCJ
'' SIG '' SlGkmmzItx9KGg5pqdfcwX7RSXCqtq27ckdjF/qm1qKm
'' SIG '' huyoEESbY7ayaYkGx0aGehg/6MUdIdV7+QIjLcVBy78d
'' SIG '' TMgW77Gcf/wiS0mKbhXjpn92W9FTeZGFndXS2z1zNfM8
'' SIG '' rlSyUkdqwKoTldKOEdqZZ14yjPs3hdHcdYWch8ZaV4XC
'' SIG '' v90Nj4ybLeu07s8n07VeafqkFgQBpyRnc89NT7beBVaX
'' SIG '' evfpUk30dwVPhcbYC/GO7UIJ0Q124yNWeCImNr7KsYxu
'' SIG '' qh3khdpHM2KPpMmRM19xHkCvmGXJIuhCISWKHC1g2TeJ
'' SIG '' QYkqFg/XYTyUaGBS79ZHmaCAQO4VgXc+nOBTGBpQHTiV
'' SIG '' mx5mMxMnORd4hzbOTsNfsvU9R1O24OXbC2E9KteSLM43
'' SIG '' Wj5AQjGkHxAIwlacvyRdUQKdannSF9PawZSOB3slcUSr
'' SIG '' Bmrm1MbfI5qWdcUxghaEMIIWgAIBATCBlTB+MQswCQYD
'' SIG '' VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
'' SIG '' A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
'' SIG '' IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQg
'' SIG '' Q29kZSBTaWduaW5nIFBDQSAyMDEwAhMzAAACJG2S5VjK
'' SIG '' df54AAAAAAIkMA0GCWCGSAFlAwQCAQUAoIIBBDAZBgkq
'' SIG '' hkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3
'' SIG '' AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
'' SIG '' IgQgLQn6o9kUODATKIS+smjNPFWNt2x3Bw5gzkZaBTK4
'' SIG '' sbgwPAYKKwYBBAGCNwoDHDEuDCxyQlBoM1B4TUFKaENP
'' SIG '' c3pScFdYbHR1b3NpOXR1UisrOUVVdUUxQTNTL0JBPTBa
'' SIG '' BgorBgEEAYI3AgEMMUwwSqAkgCIATQBpAGMAcgBvAHMA
'' SIG '' bwBmAHQAIABXAGkAbgBkAG8AdwBzoSKAIGh0dHA6Ly93
'' SIG '' d3cubWljcm9zb2Z0LmNvbS93aW5kb3dzMA0GCSqGSIb3
'' SIG '' DQEBAQUABIIBAGQMpUypEGmVbkYR01Ru2MuXRmRdhZPL
'' SIG '' fa5TnUemiSYtwHcta21BgrgfsAJ2Jk+pelmXGpARqxZP
'' SIG '' rjAT3CHVY/FUdnFKWnYRhYuwUA6aW8j91NhsWLauzvo6
'' SIG '' ymbMT2PLRlewjWx2uM6nRUgmcTvpIFRQnuL00pM0UTul
'' SIG '' rtMJKcIGmk9OMTOCSv91rPEwc4OwZynkOI1havOKhgo6
'' SIG '' +Lofk11cQhy5igWh3ch23I0kPPhu/hM1+Yvm9UsmBHyq
'' SIG '' k5YiGMGevPZrAoO8FZ6Z/AGAT0Zrc7/4/dIPpGiF1bGi
'' SIG '' QEeNjAcwLkHGByNJMRoch6nOQUy1ncQ7YJnhmU14WOI/
'' SIG '' tY+hghO3MIITswYKKwYBBAGCNwMDATGCE6MwghOfBgkq
'' SIG '' hkiG9w0BBwKgghOQMIITjAIBAzEPMA0GCWCGSAFlAwQC
'' SIG '' AQUAMIIBWAYLKoZIhvcNAQkQAQSgggFHBIIBQzCCAT8C
'' SIG '' AQEGCisGAQQBhFkKAwEwMTANBglghkgBZQMEAgEFAAQg
'' SIG '' 4b6zUSDfiEL8zVv/HzW9Xo460FHCJTwDLi5FKYYjvTgC
'' SIG '' BlvOGLnR3xgTMjAxODEwMjMxNzQ5MjguODEyWjAHAgEB
'' SIG '' gAIB9KCB1KSB0TCBzjELMAkGA1UEBhMCVVMxEzARBgNV
'' SIG '' BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
'' SIG '' HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEp
'' SIG '' MCcGA1UECxMgTWljcm9zb2Z0IE9wZXJhdGlvbnMgUHVl
'' SIG '' cnRvIFJpY28xJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNO
'' SIG '' OkI4RUMtMzBBNC03MTQ0MSUwIwYDVQQDExxNaWNyb3Nv
'' SIG '' ZnQgVGltZS1TdGFtcCBTZXJ2aWNloIIPHzCCBnEwggRZ
'' SIG '' oAMCAQICCmEJgSoAAAAAAAIwDQYJKoZIhvcNAQELBQAw
'' SIG '' gYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
'' SIG '' dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
'' SIG '' aWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1p
'' SIG '' Y3Jvc29mdCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0
'' SIG '' eSAyMDEwMB4XDTEwMDcwMTIxMzY1NVoXDTI1MDcwMTIx
'' SIG '' NDY1NVowfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldh
'' SIG '' c2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
'' SIG '' BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UE
'' SIG '' AxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAw
'' SIG '' ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCp
'' SIG '' HQ28dxGKOiDs/BOX9fp/aZRrdFQQ1aUKAIKF++18aEss
'' SIG '' X8XD5WHCdrc+Zitb8BVTJwQxH0EbGpUdzgkTjnxhMFmx
'' SIG '' MEQP8WCIhFRDDNdNuDgIs0Ldk6zWczBXJoKjRQ3Q6vVH
'' SIG '' gc2/JGAyWGBG8lhHhjKEHnRhZ5FfgVSxz5NMksHEpl3R
'' SIG '' YRNuKMYa+YaAu99h/EbBJx0kZxJyGiGKr0tkiVBisV39
'' SIG '' dx898Fd1rL2KQk1AUdEPnAY+Z3/1ZsADlkR+79BL/W7l
'' SIG '' msqxqPJ6Kgox8NpOBpG2iAg16HgcsOmZzTznL0S6p/Tc
'' SIG '' ZL2kAcEgCZN4zfy8wMlEXV4WnAEFTyJNAgMBAAGjggHm
'' SIG '' MIIB4jAQBgkrBgEEAYI3FQEEAwIBADAdBgNVHQ4EFgQU
'' SIG '' 1WM6XIoxkPNDe3xGG8UzaFqFbVUwGQYJKwYBBAGCNxQC
'' SIG '' BAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1Ud
'' SIG '' EwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAU1fZWy4/oolxi
'' SIG '' aNE9lJBb186aGMQwVgYDVR0fBE8wTTBLoEmgR4ZFaHR0
'' SIG '' cDovL2NybC5taWNyb3NvZnQuY29tL3BraS9jcmwvcHJv
'' SIG '' ZHVjdHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3Js
'' SIG '' MFoGCCsGAQUFBwEBBE4wTDBKBggrBgEFBQcwAoY+aHR0
'' SIG '' cDovL3d3dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9N
'' SIG '' aWNSb29DZXJBdXRfMjAxMC0wNi0yMy5jcnQwgaAGA1Ud
'' SIG '' IAEB/wSBlTCBkjCBjwYJKwYBBAGCNy4DMIGBMD0GCCsG
'' SIG '' AQUFBwIBFjFodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20v
'' SIG '' UEtJL2RvY3MvQ1BTL2RlZmF1bHQuaHRtMEAGCCsGAQUF
'' SIG '' BwICMDQeMiAdAEwAZQBnAGEAbABfAFAAbwBsAGkAYwB5
'' SIG '' AF8AUwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqGSIb3
'' SIG '' DQEBCwUAA4ICAQAH5ohRDeLG4Jg/gXEDPZ2joSFvs+um
'' SIG '' zPUxvs8F4qn++ldtGTCzwsVmyWrf9efweL3HqJ4l4/m8
'' SIG '' 7WtUVwgrUYJEEvu5U4zM9GASinbMQEBBm9xcF/9c+V4X
'' SIG '' NZgkVkt070IQyK+/f8Z/8jd9Wj8c8pl5SpFSAK84Dxf1
'' SIG '' L3mBZdmptWvkx872ynoAb0swRCQiPM/tA6WWj1kpvLb9
'' SIG '' BOFwnzJKJ/1Vry/+tuWOM7tiX5rbV0Dp8c6ZZpCM/2pi
'' SIG '' f93FSguRJuI57BlKcWOdeyFtw5yjojz6f32WapB4pm3S
'' SIG '' 4Zz5Hfw42JT0xqUKloakvZ4argRCg7i1gJsiOCC1JeVk
'' SIG '' 7Pf0v35jWSUPei45V3aicaoGig+JFrphpxHLmtgOR5qA
'' SIG '' xdDNp9DvfYPw4TtxCd9ddJgiCGHasFAeb73x4QDf5zEH
'' SIG '' pJM692VHeOj4qEir995yfmFrb3epgcunCaw5u+zGy9iC
'' SIG '' tHLNHfS4hQEegPsbiSpUObJb2sgNVZl6h3M7COaYLeqN
'' SIG '' 4DMuEin1wC9UJyH3yKxO2ii4sanblrKnQqLJzxlBTeCG
'' SIG '' +SqaoxFmMNO7dDJL32N79ZmKLxvHIa9Zta7cRDyXUHHX
'' SIG '' odLFVeNp3lfB0d4wwP3M5k37Db9dT+mdHhk4L7zPWAUu
'' SIG '' 7w2gUDXa7wknHNWzfjUeCLraNtvTX4/edIhJEjCCBPUw
'' SIG '' ggPdoAMCAQICEzMAAADMOr07cjgRBboAAAAAAMwwDQYJ
'' SIG '' KoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNV
'' SIG '' BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
'' SIG '' HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEm
'' SIG '' MCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENB
'' SIG '' IDIwMTAwHhcNMTgwODIzMjAyNjI1WhcNMTkxMTIzMjAy
'' SIG '' NjI1WjCBzjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldh
'' SIG '' c2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
'' SIG '' BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEpMCcGA1UE
'' SIG '' CxMgTWljcm9zb2Z0IE9wZXJhdGlvbnMgUHVlcnRvIFJp
'' SIG '' Y28xJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOkI4RUMt
'' SIG '' MzBBNC03MTQ0MSUwIwYDVQQDExxNaWNyb3NvZnQgVGlt
'' SIG '' ZS1TdGFtcCBTZXJ2aWNlMIIBIjANBgkqhkiG9w0BAQEF
'' SIG '' AAOCAQ8AMIIBCgKCAQEAx9BVpYomFWsV3fB3mLu1+cxT
'' SIG '' SwZxMScSZOo9LyP6eVEotWi1ut8dW9O6C4MKVYhzX6We
'' SIG '' zDqCfP6aAlPljpXMganBpFhMx7dwn1f/9c5kFrvG5e70
'' SIG '' DjoeI7ZPmugkGQn2Ui3bry+hK9eaMZAD3Xc3WdaGxzpQ
'' SIG '' ThW46w/nqIe62IdK0nYCAxisOukkQEjYpRWT9cIRumIh
'' SIG '' pnISfn2yHuIwEiTU4mnchKNBe34BiPGBKhZqrNK83+iP
'' SIG '' VFa76/SAV4tEGV2sWKEU70+9ncepInqzty2Y5mRid+Y2
'' SIG '' M7CF5WZ0ePdCe55tt5jSE4MW1VdiW9BTsPDZIFDpcRye
'' SIG '' XrFgcuUiiwIDAQABo4IBGzCCARcwHQYDVR0OBBYEFK2p
'' SIG '' TaZKwmUQT9frex4hmjEzSOupMB8GA1UdIwQYMBaAFNVj
'' SIG '' OlyKMZDzQ3t8RhvFM2hahW1VMFYGA1UdHwRPME0wS6BJ
'' SIG '' oEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kv
'' SIG '' Y3JsL3Byb2R1Y3RzL01pY1RpbVN0YVBDQV8yMDEwLTA3
'' SIG '' LTAxLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUH
'' SIG '' MAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kv
'' SIG '' Y2VydHMvTWljVGltU3RhUENBXzIwMTAtMDctMDEuY3J0
'' SIG '' MAwGA1UdEwEB/wQCMAAwEwYDVR0lBAwwCgYIKwYBBQUH
'' SIG '' AwgwDQYJKoZIhvcNAQELBQADggEBAD1dXWqC6eJlUTVS
'' SIG '' w8kcv+ARYFYQp5hy5kO6eCEIwbOrcCnbSTyqxGMoTCYu
'' SIG '' nCNArgSseGBku6NgIJGTGkBwdypSvN8FCXqExsuonAk1
'' SIG '' GYW7/sfgwkBySX7iUiY5SwlECOKF4eXrt+rlX6LwswGD
'' SIG '' wtg08rLiQKhNS9L+qBSE6tWdAKq0Q0lMMzGOY557M72S
'' SIG '' +o+28jHvoNJ0q2D49egT9SBdzfEvpEF42LHvox1TyUs6
'' SIG '' qDhLUaz0HkrLFm/xO19/XJNT8TaQzA5/xCfNaerk19oN
'' SIG '' nXxNTOXJpwvjsYdbcrndNZ1bK37F+FgauTQpVweKnPWn
'' SIG '' 3YB7UF7lfulKImsu2N+hggOtMIIClQIBATCB/qGB1KSB
'' SIG '' 0TCBzjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
'' SIG '' bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
'' SIG '' FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEpMCcGA1UECxMg
'' SIG '' TWljcm9zb2Z0IE9wZXJhdGlvbnMgUHVlcnRvIFJpY28x
'' SIG '' JjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOkI4RUMtMzBB
'' SIG '' NC03MTQ0MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1T
'' SIG '' dGFtcCBTZXJ2aWNloiUKAQEwCQYFKw4DAhoFAAMVAHPa
'' SIG '' hzH9Lvs8aKzn6EaUc0SHv5ZNoIHeMIHbpIHYMIHVMQsw
'' SIG '' CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQ
'' SIG '' MA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9z
'' SIG '' b2Z0IENvcnBvcmF0aW9uMSkwJwYDVQQLEyBNaWNyb3Nv
'' SIG '' ZnQgT3BlcmF0aW9ucyBQdWVydG8gUmljbzEnMCUGA1UE
'' SIG '' CxMebkNpcGhlciBOVFMgRVNOOjU3RjYtQzFFMC01NTRD
'' SIG '' MSswKQYDVQQDEyJNaWNyb3NvZnQgVGltZSBTb3VyY2Ug
'' SIG '' TWFzdGVyIENsb2NrMA0GCSqGSIb3DQEBBQUAAgUA33mR
'' SIG '' RDAiGA8yMDE4MTAyMzEyMjMzMloYDzIwMTgxMDI0MTIy
'' SIG '' MzMyWjB0MDoGCisGAQQBhFkKBAExLDAqMAoCBQDfeZFE
'' SIG '' AgEAMAcCAQACAhrrMAcCAQACAho0MAoCBQDfeuLEAgEA
'' SIG '' MDYGCisGAQQBhFkKBAIxKDAmMAwGCisGAQQBhFkKAwGg
'' SIG '' CjAIAgEAAgMW42ChCjAIAgEAAgMHoSAwDQYJKoZIhvcN
'' SIG '' AQEFBQADggEBAGQcZ9nAootHRZoPltnLS13tX1h1Y2Sh
'' SIG '' BIuvxcjAWkydlSuUHB9mDMsdwu/DsesOuUHRs6PbpDhP
'' SIG '' HQ2rUHDflkMQbzfUeQjxVahISdcNBNwbHw2VVTNLSxhW
'' SIG '' XbAzX3EBUQtvhH/0p6NvQdmRQRaAo/z6QuzWwxKRJil2
'' SIG '' 0OUYeWSh9F2P90Q5fnhHcdtgVdG3aJa/bLhiaZfLBMWo
'' SIG '' kY1eH9LZrX6ZeSvTooPa5CcAvmxTCXGCBHfZmHqsZnU/
'' SIG '' 8BmPmHgJHXybSwiHqEz/Qmu1hVTEdycKLRGTb9KTQRKV
'' SIG '' Ee5e9jKQnPOWKDNf6zpzW6c2cYj07PKmYcw7mAhdQ+Gc
'' SIG '' SMUxggL1MIIC8QIBATCBkzB8MQswCQYDVQQGEwJVUzET
'' SIG '' MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVk
'' SIG '' bW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0
'' SIG '' aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFt
'' SIG '' cCBQQ0EgMjAxMAITMwAAAMw6vTtyOBEFugAAAAAAzDAN
'' SIG '' BglghkgBZQMEAgEFAKCCATIwGgYJKoZIhvcNAQkDMQ0G
'' SIG '' CyqGSIb3DQEJEAEEMC8GCSqGSIb3DQEJBDEiBCDJy8Sz
'' SIG '' ZNEoTrDZC6ebcworMlQFjddnWJZSoVc3B6+t4TCB4gYL
'' SIG '' KoZIhvcNAQkQAgwxgdIwgc8wgcwwgbEEFHPahzH9Lvs8
'' SIG '' aKzn6EaUc0SHv5ZNMIGYMIGApH4wfDELMAkGA1UEBhMC
'' SIG '' VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcT
'' SIG '' B1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
'' SIG '' b3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUt
'' SIG '' U3RhbXAgUENBIDIwMTACEzMAAADMOr07cjgRBboAAAAA
'' SIG '' AMwwFgQU71wmANRsfgUxy19oJgQca/wpHbwwDQYJKoZI
'' SIG '' hvcNAQELBQAEggEACMzaE2jcxRTu+uoe4XY3ZMgoHvUa
'' SIG '' 8HGn/xqNxDQGe7hGHSOOwzPj0eG4ryvurcRt+ui1Gluc
'' SIG '' hDuJy+NmV1ZAXXCDOyMvYWzehvLqN3mCIsOuR0ia1G7H
'' SIG '' nwob4C/UexfX1ayMj8dG+saYb8WpTJrpJTIiKpiq1HBz
'' SIG '' Pt/Uh8/K8MfHCbUjQce5032zsbKf4fjPWhIIV8efKWT/
'' SIG '' Gv9XHomTOafroHBOrLASfzjtw4SZmsKbsA+J60LgAcSc
'' SIG '' rhO/uoILsL7aFsSHF1SGG58uHrOtGP4/pUvowTvPU5Gz
'' SIG '' KkKpCYwVjBPwd4LJtbQ841tvPsHRbaxtSHXnKNlmaiKh
'' SIG '' 3sb7wQ==
'' SIG '' End signature block
