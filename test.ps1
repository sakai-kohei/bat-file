$result="C:\Users\la0760\Desktop\バッチファイル検証\logs\batch_file\result.txt"
$original="E:\Tableau_PDF"
$title="Backup"
$date=Get-Date

echo $result
echo $original
echo "[$date $title]"
Param( $aaa, $bbb )
echo "aaa: $aaa"
echo "bbb: $bbb"