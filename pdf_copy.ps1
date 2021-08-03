<# =====================================================================
PDFフォルダ同期バッチファイル Ver1.0
Date  :2021/07/28

resultは、実行時のメッセージを格納するテキスト
originalは、同期元のフォルダ
dateは、バッチ実行時の日付と時間
titleは、メッセージを格納している変数
yearは、作成したレポートが属する年度を格納する変数
monthは、作成したレポートが属する月を格納する変数
iは、終了条件を格納する変数
ansは、バッチ実行を継続するかを入力させてその文字列を格納する変数
pathは、コピー先フォルダの定数部分を格納する変数
copiedは、同期先のフォルダ
=====================================================================#>

$result="E:\logs\bat\pdf_copy\result.txt"
$original="E:\Tableau_PDF"
$date=Get-Date
$title="Backup"
$kotosi=(Get-Date).Year
$path="Z:\AO_経営企画室\82. Tableauレポート\"
$i=1

echo "[$date $title] バッチの実行を開始します。 " |  Add-Content $result –pass
do {
 $year = Read-Host "作成したレポートの年度を[yyyy]で入力してください。" |  Add-Content $result –pass
 if (($year -gt $kotosi) -Or ($year -lt 2009)) {
  echo "[$date $title] 入力された""$year""は無効です。もう一度入力してください。" |  Add-Content $result –pass
 }else{
  $i=0
 }
}while($i -eq 1)

 do {
  $month = Read-Host "作成したレポートの月を[mm]で入力してください。"  
  if(-not(($month -eq "01") -Or ($month -eq "02") -Or ($month -eq "03") -Or ($month -eq "04") -Or ($month -eq "05") -Or ($month -eq "06") -Or ($month -eq "07") -Or ($month -eq "08") -Or ($month -eq "09") -Or ($month -eq "10") -Or ($month -eq "11") -Or ($month -eq "12"))){
   echo "[$date $title] 入力された""$month""は無効です。もう一度入力してください。"  |  Add-Content $result –pass
  }
  else{
   $i=1
  }
}while($i -eq 0)


$ans = Read-Host "作成したレポートを"$year"年度"$month"月にコピーします。よろしければy、バッチの実行を停止したい場合はnを入力してください。" |  Add-Content $result –pass
if($ans -eq "y"){
 echo "[$date $title] 入力したフォルダを作成し、同期を開始します。" |  Add-Content $result –pass
}
else {
 echo "[$date $title] バッチの実行を中止します。 " |  Add-Content $result –pass
 exit
}

$copied=$path+$year+"年度\"+$month+"月"
if(-not(Test-Path $copied)) {
 mkdir $copied
}

robocopy $original $copied /mir /w:1  |  Add-Content $result –pass
echo "エラーレベル=$LASTEXITCODE" |  Add-Content $result –pass
if($LASTEXITCODE -eq "1"){
 echo "[$date $title] バッチの実行により、同期が成功しました。" |  Add-Content $result –pass
 exit
}
if($LASTEXITCODE -eq "0"){
 echo "[$date $title] 同期の必要がなかったため、バッチは実行されませんでした。" |  Add-Content $result –pass
 exit
 }
if($LASTEXITCODE -gt "1"){
 echo "[$date $title] エラーが発生したため、バッチの実行が失敗しました。" |  Add-Content $result –pass
}