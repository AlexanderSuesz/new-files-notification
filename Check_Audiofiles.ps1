# Schaut nach, ob es in Onedrive im Folder "Apps\Easy Voice Recorder Pro" neue (Audio)-Dateien gibt. Wenn ja, dann wird eine simple Windows Notification gesendet.
# Muss beim Autostart gestartet werden!

function Start-Interactive-Window{
    $wshell = New-Object -ComObject Wscript.Shell
    $Output = $wshell.Popup("Du hast neue noch nicht bearbeitete Audioafnahmen! Willst du sie jetzt durchgehen?",0,"                                             High Rank Quest",1+32)
    if ($Output -eq 1) {
        Invoke-Item $audiopath
        echo "$((Get-Date).ToString()): Script worked successful. Onedrive Folder was opened."
        Break;
    }
    else {
        echo "$((Get-Date).ToString()): Script worked successful. Cancel was pressed."
        Break
    }
}

if ($env:onedrive -eq $null) { # Prüft, ob ein Pfad in der onedrive Variable gespeichert ist.
    echo "The onedrive variable is null."
} 
else { 
    $audiopath = $env:onedrive + "\Apps\Easy Voice Recorder Pro" # Der Pfad zum Ordner "Easy Voice Recorder Pro".
    $filesinsideaudiopath = $audiopath + "/*" # Repräsentiert beliebige Files in dem "Easy Voice Recorder Pro" Folder. 
    if(Test-Path -Path $filesinsideaudiopath){
        Start-Interactive-Window
    }   
    # Wenn nichts findet, schaut nach 5 Min nach, ob doch noch was erhalten habe und startet das interaktive Fenster, wenn dem so ist.
    else {
        Start-Sleep -Seconds 300
        if(Test-Path -Path $filesinsideaudiopath){ # Wenn nach 5 Minuten immer noch keine Files im Folder gefunden werden, dann beendet sich das Programm
            Start-Interactive-Window
        }
    }
}