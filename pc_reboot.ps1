<# =====================================================================
PC再起動バッチファイル Ver1.0
Date  :2021/07/28

resultは、実行時のメッセージを格納するテキスト
dateは、バッチ実行時の日付と時間
titleは、メッセージを格納している変数
=====================================================================#>

$result="E:\logs\bat\pc_reboot\result.txt"
$title="PC_REBOOT"

echo ("["+(Get-Date -Format G)+" $title] PCの再起動の実行を始めます。") |  Add-Content $result -Encoding UTF8  –pass
sc.exe query MySQL80 | findstr STATE | findstr RUNNING > null
if($LASTEXITCODE -eq 1){
 echo ("["+(Get-Date -Format G)+" $title] MySQL80は停止していました。") |  Add-Content $result -Encoding UTF8 –pass
}elseif($LASTEXITCODE -eq 0){
 echo ("["+(Get-Date -Format G)+" $title] MySQL80が稼働していたため、停止を実行します。") |  Add-Content $result -Encoding UTF8 –pass
 echo ("["+(Get-Date -Format G)+" $title] MySQL80の停止を開始します。")  |  Add-Content $result -Encoding UTF8 –pass
 net stop MySQL80
 timeout /T 5
 sc.exe query MySQL80 | findstr STATE | findstr RUNNING > null
 if($LASTEXITCODE -eq 1){
  echo ("["+(Get-Date -Format G)+" $title] MySQL80の停止に成功しました。") |  Add-Content $result -Encoding UTF8 –pass
 }else{
  echo ("["+(Get-Date -Format G)+" $title] MySQL80の停止に失敗しました。バッチの実行を停止します。") |  Add-Content $result -Encoding UTF8 –pass
  exit
 }
}else{
 echo ("["+(Get-Date -Format G)+" $title] MySQL80の状態が確認できませんでした。バッチの実行を停止します。") |  Add-Content $result -Encoding UTF8 –pass
 exit
}

echo ("["+(Get-Date -Format G)+" $title] PCの再起動を開始します。") |  Add-Content $result -Encoding UTF8 –pass

echo ("["+(Get-Date -Format G)+" $title] エラーレベル=$LASTEXITCODE") |  Add-Content $result -Encoding UTF8 –pass
if (-not($LASTEXITCODE -eq 0)){
echo ("["+(Get-Date -Format G)+" $title] PCの再起動に失敗しました。") |  Add-Content $result -Encoding UTF8 –pass
exit
}
echo ("["+(Get-Date -Format G)+" $title] PCの再起動を実行します。") |  Add-Content $result -Encoding UTF8 –pass