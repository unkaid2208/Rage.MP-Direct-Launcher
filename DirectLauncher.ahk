#SingleInstance, Force
#KeyHistory 0

;==ADMIN=RIGHTS=OVERRIDER============================================
full_command_line := DllCall("GetCommandLine", "str")

If Not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    Try
    {
        If A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        Else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}


;==LAUCHER===========================================================
RageRegPath := "HKEY_CURRENT_USER\SOFTWARE\RAGE-MP"
ServerIp := "127.0.0.1"
ServerPort := "22005"
RageParams = {"language":"ru","hideAfterBootGame":false,"showIntro":false,"patchGTA":false,"changeRAGEMPFolder":"button","clearCache":"button","forceClearCache":"button"}

RegRead, ragepath, %RageRegPath%, rage_path

RegWrite, REG_SZ, %RageRegPath%, launch2.ip, %ServerIp%
RegWrite, REG_SZ, %RageRegPath%, launch2.port, %ServerPort%
RegWrite, REG_SZ, %RageRegPath%, launch2.params, %RageParams%
Sleep, 420 ;Just because
Run, %ragepath%\updater.exe

;Cleaning the current server params in registry
Sleep, 5000
RegWrite, REG_SZ, %RageRegPath%, launch2.ip, 
RegWrite, REG_SZ, %RageRegPath%, launch2.port, 
RegWrite, REG_SZ, %RageRegPath%, launch2.params, 
