$result="E:\logs\bat\pc_reboot\pc_reboot.txt"
$date=Get-Date
$title="PC_REBOOT"

echo "[$date $title] PCの再起動の実行を始めます。" |  Add-Content $result –pass
sc.exe query MySQL80 | findstr STATE | findstr RUNNING > null

if($LASTEXITCODE -eq 0){
 echo "[$date $title] MySQL80が稼働していたため、停止を実行します。" |  Add-Content $result –pass
 echo "[$date $title] MySQL80の停止を開始します。" |  Add-Content $result –pass
 net stop MySQL80
 timeout /T 5

 sc.exe query MySQL80 | findstr STATE | findstr RUNNING > null
 if($LASTEXITCODE -eq 0){
  echo "[$date $title] MySQL80の停止に失敗しました。" |  Add-Content $result –pass
  exit
 }elseif($LASTEXITCODE -eq 1){
  echo "[$date $title] MySQL80の停止に成功しました。" |  Add-Content $result –pass
 }else{
  echo "[$date $title] MySQL80の停止に失敗しました。バッチの実行を停止します。" |  Add-Content $result –pass
 }
}elseif($LASTEXITCODE -eq 1){
 echo "[$date $title] MySQL80は停止していました。" |  Add-Content $result –pass
}else{
 echo "[$date $title] MySQL80の停止に失敗しました。バッチの実行を停止します。" |  Add-Content $result –pass
}

echo "[$date $title] PCの再起動を開始します。" |  Add-Content $result –pass
shutdown.exe -r -t 10
echo "[$date $title] エラーレベル=$LASTEXITCODE" |  Add-Content $result –pass
if (-not($LASTEXITCODE -eq 0)){
echo "[$date $title] PCの再起動に失敗しました。" |  Add-Content $result –pass
}
echo "[$date $title] PCの再起動を実行します。" |  Add-Content $result –pass