@echo off
CHCP 65001

SET result="E:\logs\bat\pc_reboot\result.txt"
SET title=[PC_REBOOT]

echo %date% %time% %title% MySQL80の稼働を確認します。 >>%result%
sc query MySQL80 | findstr STATE | findstr RUNNING > null
echo %date% %time% %title% エラーレベル=%errorlevel% >>%result%
if %errorlevel%==0 (
echo %date% %time% %title% MySQL80が稼働していたため、停止を実行します。 >>%result%
net stop MySQL80
timeout /T 5
setlocal enabledelayedexpansion
sc query MySQL80 | findstr STATE | findstr RUNNING > null
echo %date% %time% %title% エラーレベル=!errorlevel! >>%result%
if !errorlevel!==0 (
echo %date% %time% %title% MySQL80の停止に失敗しました。  >>%result%&goto :eof
) else !errorlevel!==1 (
echo %date% %time% %title% MySQL80の停止に成功しました。  >>%result%&goto :reboot
)
endlocal
) else (
echo %date% %time% %title% MySQL80は停止していました。 >>%result%
)
:reboot

echo %date% %time% %title% PCの再起動を開始します。 >>%result%
shutdown.exe -r -t 10 >>%result%
echo %date% %time% %title% エラーレベル=%errorlevel% >>%result%
if not %errorlevel%==0 (
echo %date% %time% %title% PCの再起動に失敗しました。 >>%result%& goto :eof
)
echo %date% %time% %title% PCの再起動が正常に開始されました。 >>%result%