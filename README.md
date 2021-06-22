# ahkransom
A POC of a very simple ransomware script written in Autohotkey.

This is for educational purposes only, use at your own discretion and responsibility on systems where you have authority to execute such code.

ransom.ahk is the ransomware, while crypto.ahk is the encryption library to interface with brypt.dll

Requires Autohotkey 1.1+ to run, can also be compiled to a standalone binary.

The script has two modes: encryption and decryption. Works by default recursively in the working directory of the script encrypting a predefined list of extensions.

Script encrypts files with AES-CBC with a hardcoded encryption key and IV and produces and opens a ransom note on the users Desktop along with a full list of encrypted files.

Switching the mode to decryption reverses the process.
