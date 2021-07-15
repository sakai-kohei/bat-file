$result="E:\logs\batch_file\result.txt"
$original="E:\Tableau_PDF"
$date=Get-Date
$title="Backup]"
$kotosi=(Get-Date).Year

$year = Read-Host "作成したレポートの年度を[yyyy]で入力してください。" 
if ($year -gt $kotosi) {
echo "[$date $title 今年度以降の年が入力されています。もう一度入力してください。">> $result
exit
}
if ($year -lt 2009){
echo "[$date $title 入力した年度に実績はありません。もう一度入力してください。">> $result
exit
}

$month = Read-Host "作成したレポートの月を[mm]で入力してください。"
if(-not(($month -eq 01) -Or ($month -eq 02) -Or ($month -eq 03) -Or ($month -eq 04) -Or ($month -eq 05) -Or ($month -eq 06) -Or ($month -eq 07) -Or ($month -eq 08) -Or ($month -eq 09) -Or ($month -eq 10) -Or ($month -eq 11) -Or ($month -eq 12))){
echo "[$date $title 入力が無効です。もう一度入力してください。">> $result
exit
}

$ans = Read-Host "作成したレポートを"$year"年度"$month"月にコピーします。よろしければy、バッチの実行を停止したい場合はnを入力してください。"
if($ans -eq "y"){
echo "[$date $title 入力したフォルダを作成し、同期を開始します。">> $result
}
else {
echo "[$date $title バッチの実行を中止します。 ">> $result
exit
}

$copied="Z:\AO_経営企画室\82. Tableauレポート\"+$year+"年度\"+$month+"月"
if(-not(Test-Path $copied)) {
echo $copied
mkdir $copied
}
echo $copied
robocopy $original $copied /mir /w:1 >> $result
echo "エラーレベル=$LASTEXITCODE">> $result
if($LASTEXITCODEl -eq 1){
 echo "[$date $title バッチの実行により、同期が成功しました。">> $result
 exit
}
if($LASTEXITCODE -eq 0){
 echo "[$date $title 同期の必要がなかったため、バッチは実行されませんでした。">> $result
 exit
 }
 if($LASTEXITCODE -gt 1){
 echo "[$date $title エラーが発生したため、バッチの実行が失敗しました。">> $result
 }