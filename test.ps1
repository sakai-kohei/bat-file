$result="E:\logs\batch_file\result.txt"
$original="E:\Tableau_PDF"
$date=Get-Date
$title="Backup]"
$kotosi=(Get-Date).Year

$year = Read-Host "�쐬�������|�[�g�̔N�x��[yyyy]�œ��͂��Ă��������B" 
if ($year -gt $kotosi) {
echo "[$date $title ���N�x�ȍ~�̔N�����͂���Ă��܂��B������x���͂��Ă��������B">> $result
exit
}
if ($year -lt 2009){
echo "[$date $title ���͂����N�x�Ɏ��т͂���܂���B������x���͂��Ă��������B">> $result
exit
}

$month = Read-Host "�쐬�������|�[�g�̌���[mm]�œ��͂��Ă��������B"
if(-not(($month -eq 01) -Or ($month -eq 02) -Or ($month -eq 03) -Or ($month -eq 04) -Or ($month -eq 05) -Or ($month -eq 06) -Or ($month -eq 07) -Or ($month -eq 08) -Or ($month -eq 09) -Or ($month -eq 10) -Or ($month -eq 11) -Or ($month -eq 12))){
echo "[$date $title ���͂������ł��B������x���͂��Ă��������B">> $result
exit
}

$ans = Read-Host "�쐬�������|�[�g��"$year"�N�x"$month"���ɃR�s�[���܂��B��낵�����y�A�o�b�`�̎��s���~�������ꍇ��n����͂��Ă��������B"
if($ans -eq "y"){
echo "[$date $title ���͂����t�H���_���쐬���A�������J�n���܂��B">> $result
}
else {
echo "[$date $title �o�b�`�̎��s�𒆎~���܂��B ">> $result
exit
}

$copied="Z:\AO_�o�c��掺\82. Tableau���|�[�g\"+$year+"�N�x\"+$month+"��"
if(-not(Test-Path $copied)) {
echo $copied
mkdir $copied
}
echo $copied
robocopy $original $copied /mir /w:1 >> $result
echo "�G���[���x��=$LASTEXITCODE">> $result
if($LASTEXITCODEl -eq 1){
 echo "[$date $title �o�b�`�̎��s�ɂ��A�������������܂����B">> $result
 exit
}
if($LASTEXITCODE -eq 0){
 echo "[$date $title �����̕K�v���Ȃ��������߁A�o�b�`�͎��s����܂���ł����B">> $result
 exit
 }
 if($LASTEXITCODE -gt 1){
 echo "[$date $title �G���[�������������߁A�o�b�`�̎��s�����s���܂����B">> $result
 }