$kvnames = @('testkeyvaultssg1', 'keyvaulttemplategopi')
$secretnames = @('app1', 'app2','2226')
$secretvalues = @('app1', 'app2','2226')

for ($kvn = 0; $kvn -le $kvnames.count - 1; $kvn++) {
    $kvnames[$kvn] 
    $kvlist = az keyvault secret list --vault-name $kvnames[$kvn] | ConvertFrom-Json
    $kvlist.name.count

    Write-Output "-------------------------------------"
    $allsecretvalues =@()
    $allsecretnames =@()

    for ($secretlist = 0; $secretlist -le $kvlist.names.count - 1; $secretlist++) {
        $kvsecret = az keyvault secret show --vault-name $kvnames[$kvn]  --name $kvlist.name[$secretlist]
        $allsecretvalues += ($kvsecret | ConvertFrom-Json).value
        $allsecretnames += ($kvsecret | ConvertFrom-Json).name
    } 

    Write-Output "================================="
    $alreadyexist = 0

    for ($i = 0; $i -le $secretnames.count - 1; $i++) {
        for ($j = 0; $j -le $allsecretnames.count - 1; $j++) {
            if ($secretnames[$i] -eq $allsecretnames[$j]) {
                if ($secretvalues[$i] -eq $allsecretvalues[$j]) {
                    $alreadyexist = 1
                    $secretnamethatexist = $secretnames[$i]
                    $secretvaluethatexist = $secretvalues[$i]
                } 
            } 
        }
    }
 
    $alreadyexist
    Write-Output "--------------------------------"
    if ($alreadyexist -eq 1) {
        Write-Host "Secret Already Exists - $secretnamethatexist and $secretvaluethatexist and $kvnames[$kvn] "
        $Env:AlreadyExist ='1'
    }
}
