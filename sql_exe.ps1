﻿<# =====================================================================
SQLファイル実行バッチ Ver1.0
Date  :2021/06/28

cnfは、MySQLへのログイン情報を記載しているテキスト
pathsは、実行するSQLファイルを記載するテキスト
resultは、実行時のメッセージを格納するテキスト
titleは、実行メッセージのタイトル
allは、実行したいSQLファイルの総数を格納する変数
countは、実行するSQLファイルの項番を格納する変数
txtは、実行するSQLファイル名を一時的に格納する変数
=====================================================================#>

$cnf="C:\ProgramData\MySQL\MySQL Server 8.0\login.cnf"
$paths="E:\sql_exe.txt"
$result="E:\logs\bat\sql_exe\result.txt"
$date=Get-Date
$title="SQL_EXE]"
$all=0
$count=0

$f = (Get-Content $paths -Encoding UTF8)
foreach ($l in $f) {
if(($l -eq "")){
 echo "[$date $title  テキストに実行するSQLファイルが記載されていません。バッチの実行を中止します。 " |  Add-Content $result –pass
 exit
} 
 if(-not(Test-Path $l)) {
 echo "[$date $title 「sql_exe.txt」に記入したSQLファイルのパスが間違っています。バッチの実行を中止します。 " |  Add-Content $result –pass
 exit
}
$sql=$l.Substring($l.Length -3, 3)
if (-not($sql -eq "sql" )){
 echo "[$date $title 「sql_exe.txt」には、SQLファイルを記入してください。バッチの実行を中止します。" |  Add-Content $result –pass
 exit
}
 $all++
}

$f = (Get-Content $paths -Encoding UTF8)
foreach ($l in $f) {
$count++
echo "[$date $title"$count"/"$all" "$l"の実行を始めます。 " |  Add-Content $result –pass
Get-Content $l | mysql --defaults-extra-file="$cnf" |  Add-Content $result –pass 2>&1
if($LASTEXITCODE -eq 1){
echo "[$date $title"$count"/"$all" "$l"の実行が失敗しました。" |  Add-Content $result –pass
exit
}
}
echo "[$date $title バッチの実行が正常に終了しました。" |  Add-Content $result –pass