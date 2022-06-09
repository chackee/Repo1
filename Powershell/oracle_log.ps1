$inputPath = $null
$outputPath = $null
$filename = $null
## get inputPath from user
add-type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Enter input text file!'
$form.Size = New-Object System.Drawing.Size(300,150)
$form.StartPosition = 'CenterScreen'

$button = New-Object System.Windows.Forms.Button
$form.Controls.Add($button)
$button.Text = 'Get file'
$button.Location = '10,10'
$button.add_Click({
    $ofd = New-Object System.Windows.Forms.OpenFileDialog
    $ofd.Filter = 'TXTs (*.txt)|*.txt'
    $script:filename = 'Not found'
    if($ofd.ShowDialog() -eq 'OK'){
        $script:filename = $textbox.Text = $ofd.FileName
    }
})

$buttonOK = New-Object System.Windows.Forms.Button
$form.Controls.Add($buttonOK)
$buttonOK.Text = 'OK'
$buttonOK.Location = '10,40'
$buttonOK.DialogResult = 'OK'

$textbox = New-Object System.Windows.Forms.TextBox
$form.Controls.Add($textbox)
$textbox.Location = '100,10'
$textbox.Width += 50
$form.ShowDialog()
$inputPath = $filename
$inputPathMod = $inputPath -replace ".{4}$" ## remove .txt from inputPath
$outputPath = $inputPathMod + "_correction.txt"

if(-Not ($inputPath))
{
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    $msgBody = "File not selected!"
    $msgTitle = "Error"
    $msgButton = 'OK'
    $msgImage = 'Error'
    [System.Windows.MessageBox]::Show($msgBody,$msgButton,$msgImage)
    Exit
}

## Podle data smaže datum s časem na začátku každého řádku
$dateContent = Get-Content -Path $inputPath
$lengthDate = $dateContent.Split(" ")[0]
$lengthDate = $lengthDate.length
$filecontent = $null
if($lengthDate -match '6')
{
    ## smaže prvních 19 znaků na každém řádku
    $filecontent = Get-Content -Path $InputPath | ForEach{
        $_.Remove(0,19)
    }
    $filecontent | Out-File -Encoding utf8 $outputPath
}else {
    if($lengthDate -match '7') {
        ## smaže prvních 20 znaků na každém řádku
        $filecontent = Get-Content -Path $inputPath | ForEach {
            $_.Remove(0,20)
        }
        $filecontent | Out-File -Encoding utf8 $outputPath
    }else {
        if($lengthDate -match '8') {
            ## smaže prvních 21 znaků na každém řádku
            $filecontent = Get-Content -Path $inputPath | ForEach {
            $_.Remove(0,21)
        }
        $filecontent | Out-File -Encoding utf8 $outputPath
       }else {
        Add-Type -AssemblyName PresentationCore,PresentationFramework
        $msgBody = "In WAWI.txt file appeared unexpected date on first line! Correct format is: MM/DD/YY hh:mm:ss 0>(space)"
        $msgTitle = "Text File Error"
        $msgButton = 'OK'
        $Result = [System.Windows.MessageBox]::Show($msgBody,$msgTitle,$msgButton,$msgImage)
        Exit
        }
    }
}

#zajistí aby se i poslední command dostal do correction.txt, protože script hledá hodnoty mezi [comp a ile]
Add-Content -Path $inputPath -Value "[compile]" -PassThru -NoNewline | Out-Null

##pripravi pro excel z jake cesty ma vzit data
$excelPath = "C:\Temp\Wawi_excel_path.txt"
$outputPath | Out-File $excelPath

## get macro from user

## prostor pro VBA SCRIPT
$macroPath1 = Get-Location
$macroPath2 = "\macro.xla"
$macroPath = "$macroPath1$macroPath2"
$macro = "replaceFile"
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$wb = $excel.Workbooks.Add($macroPath)
$excel.Run($macro)

Remove-Item -Path $excelPath

##oddělovač řetězce
$pattern = "ile\](.*?)\[comp"

$final = $null
## prochází correction.txt file a hledá si text mezi dvěma [compile]
Get-Item -Path $outputPath | ForEach-Object {
    $result = Get-Content $_.FullName
    [regex]::Matches($result, $pattern) | ForEach-Object {
        $g = $_.Groups[0].Value
        ##podmínky pro filtrování correction.txt
        if($g -match ' SELECT ' -and $g -match 'ERROR') ## hledá SELECT s ERROREM
        {
            $final = $final + "`n`n" + $g ## odřádkuje výsledek a přepíše correction.txt
            $final | Out-File -Encoding utf8 $outputPath
        }else {
            if($g -match ' SELECT ' -and $g -match '\:1' -or $g -match '\: 1') { ## hledá SELECT bez ERRORU a proměnné :1, :2 s hodnotami
                $final = $final + "`n`n" + $g ## odřádkuje výsledek a přepíše correction.txt
                $Final | Out-File -Encoding utf8 $outputPath
            }else {
                if($g -match ' SELECT ') { ## hledá SELECT
                    $pattern2 = "(.*?)\[describe\]"
                    $g = [regex]::match($g, $pattern2).Groups[1].Value ##hledá SELECT až po výraz [describe]
                    $final = $final + "`n`n" + $g
                    $final | Out-File -Encoding utf8 $outputPath ## vloží SELECT od compile po describe do correction.txt
                }else {
                    if($g -match ' UPDATE ' -and $g -match 'ERROR') { ## hledá UPDATE s errorem
                        $final = $final + "`n`n" + $g
                        $Final | Out-File -Encoding utf8 $outputPath
                    }else {
                        if($g -match ' UPDATE') {
                        $pattern2 = "(.*?)\[bind\]"  ##vybírá UPDATE od compile k bind textu
                        $g = [regex]::match($g, $pattern2).Groups[1].Value
                        $final = $Final + "`n`n" + $g
                        $Final | Out-File -Encoding utf8 $outputPath
                        }else {
                            $final = $final + "`n`n" + $g
                            $Final | Out-File -Encoding utf8 $outputPath ## všechny ostatní výskyty (DELETE,ALTER) přepíše do correction.txt bez úprav
                        }
                    }
                }
            }
        }
    }
}
## smaže [compile] ze souboru
$final -replace '\[comp','' | Out-File $outputPath
$final2 = Get-Content $outputPath
$final -replace 'ile\]','' | Out-File $outputPath

##zalomí řádek před každou závorkou []
$string_var = Get-Content -Path $outputPath
$string_var -split '(?=\[)' | Out-File $outputPath

##smaže fetch a end of fetch ze souboru
$final = $null
$final = Get-Content -Path $outputPath
$final -replace '\[fetch\]',''| Out-File $outputPath
$final = $null
$final = Get-Content -Path $outputPath
$final -replace '\[end of fetch\]',''| Out-File $outputPath

($final = Get-Content -Path $outputPath) -notmatch "\[commit\]" | Out-File -Encoding utf8 $outputPath ## smaže všechny řádky, které začínají [commit]
($final = Get-Content -Path $outputPath) -notmatch "\[execute\]" | Out-File -Encoding utf8 $outputPath ## smaže všechny řádky, které začínají [execute]
($final = Get-Content -Path $outputPath) -notmatch "\[get database parameter\]" | Out-File -Encoding utf8 $outputPath ## smaže všechny řádky, které začínají [get database parameter]
($final = Get-Content -Path $outputPath) -notmatch "\[set database parameter\]" | Out-File -Encoding utf8 $outputPath ## smaže všechny řádky, které začínají [set database parameter]
($final = Get-Content -Path $outputPath) -notmatch "\[describe\]" | Out-File -Encoding utf8 $outputPath ## smaže všechny řádky, které začínají [describe]
($final = Get-Content -Path $outputPath) -notmatch "\[bind\]" | Out-File -Encoding utf8 $outputPath ## smaže všechny řádky, které začínají [bind]

Add-Type -AssemblyName PresentationCore,PresentationFramework
$msgBody = "File: $outputPath has been successfuly created!"
$msgTitle = "Success"
$msgButton = 'OK'
$msgImage = 'Information'
[System.Windows.MessageBox]::Show($msgBody,$msgTitle,$msgButton,$msgImage)
