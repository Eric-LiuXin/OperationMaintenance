SET locationPath=%~dp0
SET regPath="%locationPath%DisableAutoLogon.reg"
regedit.exe /s %regPath%