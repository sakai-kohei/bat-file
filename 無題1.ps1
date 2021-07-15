$date=Get-Date
$title="Backup]"

$month = Read-Host "作成したレポートの月を[mm]で入力してください。"
if(-not(($month -eq 01) -Or ($month -eq 02) -Or ($month -eq 03) -Or ($month -eq 04) -Or ($month -eq 05) -Or ($month -eq 06) -Or ($month -eq 07) -Or ($month -eq 08) -Or ($month -eq 09) -Or ($month -eq 10) -Or ($month -eq 11) -Or ($month -eq 12))){
echo "[$date $title 入力が無効です。もう一度入力してください。">> $result
exit
}