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

$result="F:\05_logs\bat\pdf_copy\result.txt"
$original="F:\08_Tableau_PDF"
$title="Backup"
$kotosi=(Get-Date).Year
$path="Z:\AO_経営企画室\XX. Tableauレポート\"
$i=1

echo ("["+(Get-Date -Format G)+" $title] バッチの実行を開始します。") |  Add-Content $result -Encoding UTF8 –pass
do {
 $year = Read-Host "作成したレポートの年度を[yyyy]で入力してください。" |  Add-Content $result -Encoding UTF8 –pass
 if (($year -gt $kotosi) -Or ($year -lt 2009)) {
  echo ("["+(Get-Date -Format G)+" $title] 入力された""$year""は無効です。もう一度入力してください。") |  Add-Content $result -Encoding UTF8 –pass
 }else{
  $i=0
 }
}while($i -eq 1)

 do {
  $month = Read-Host "作成したレポートの月を[mm]で入力してください。" 
  if(-not(($month -eq "01") -Or ($month -eq "02") -Or ($month -eq "03") -Or ($month -eq "04") -Or ($month -eq "05") -Or ($month -eq "06") -Or ($month -eq "07") -Or ($month -eq "08") -Or ($month -eq "09") -Or ($month -eq "10") -Or ($month -eq "11") -Or ($month -eq "12"))){
   echo ("["+(Get-Date -Format G)+" $title] 入力された""$month""は無効です。もう一度入力してください。")  |  Add-Content $result -Encoding UTF8 –pass
  }else{
   $i=1
  }
}while($i -eq 0)

$ans = Read-Host "作成したレポートを"$year"年度"$month"月にコピーします。よろしければy、バッチの実行を停止したい場合はnを入力してください。" |  Add-Content $result -Encoding UTF8 –pass
if($ans -eq "y"){
 echo ("["+(Get-Date -Format G)+" $title] 入力したフォルダとの、同期を開始します。") |  Add-Content $result -Encoding UTF8 –pass
}
else {
 echo ("["+(Get-Date -Format G)+" $title] バッチの実行を中止します。 ") |  Add-Content $result -Encoding UTF8 –pass
 exit
}

$copied=$path+$year+"年度\"+$month+"月"
if(-not(Test-Path $copied)) {
 mkdir $copied
if($LASTEXITCODE -eq "0"){
 echo ("["+(Get-Date -Format G)+" $title] フォルダが新規作成されました。") |  Add-Content $result -Encoding UTF8 –pass
}else{
 echo ("["+(Get-Date -Format G)+" $title] フォルダの新規作成に失敗しました。バッチの実行を停止します。")|  Add-Content $result -Encoding UTF8 –pass
 exit
 }
}

robocopy $original $copied /mir /w:1  |  Add-Content $result -Encoding UTF8 –pass
echo ("["+(Get-Date -Format G)+" $title] エラーレベル=$LASTEXITCODE") |  Add-Content $result -Encoding UTF8 –pass
if($LASTEXITCODE -eq "1"){
 echo ("["+(Get-Date -Format G)+" $title] バッチの実行により、同期が成功しました。") |  Add-Content $result -Encoding UTF8 –pass
 exit
}elseif($LASTEXITCODE -eq "0"){
 echo ("["+(Get-Date -Format G)+" $title] 同期の必要がなかったため、バッチは実行されませんでした。") |  Add-Content $result -Encoding UTF8 –pass
 exit
}elseif($LASTEXITCODE -lt "7"){
 echo ("["+(Get-Date -Format G)+" $title] 同期先の余分なファイルが削除して、同期が実行されました。") |  Add-Content $result -Encoding UTF8 –pass
 exit
}elseif($LASTEXITCODE -gt "7"){
 echo ("["+(Get-Date -Format G)+" $title] エラーが発生したため、バッチの実行が失敗しました。") |  Add-Content $result -Encoding UTF8 –pass
}