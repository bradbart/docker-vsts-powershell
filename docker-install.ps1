param(
    [string]$CA,
    [string]$Cert, 
    [string]$Key
)

$source = "https://get.docker.com/builds/Windows/x86_64/docker-1.10.3.exe"
$destination = (Get-Item -Path ".\" -Verbose).FullName + "\docker.exe"
$certPath = (Get-Item -Path ".\" -Verbose).FullName

$dockerCAPath =  $certPath + "\ca.pem"
$dockerCertPath = $certPath + "\cert.pem"
$dockerKeyPath =  $certPath + "\key.pem"

Invoke-WebRequest $source -OutFile $destination

function GenerateCert
{
    param([string]$cert, [string]$outpath)
    $cert = $cert.Replace(" CERTIFICATE", "CERTIFICATE").Replace(" RSA PRIVATE KEY", "RSAPRIVATEKEY").Replace(" ", "`n").Replace("CERTIFICATE", " CERTIFICATE").Replace("RSAPRIVATEKEY", " RSA PRIVATE KEY")
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($cert)
    [System.IO.File]::WriteAllBytes($outpath, $bytes)
}

GenerateCert $CA $dockerCAPath
GenerateCert $Cert $dockerCertPath
GenerateCert $Key $dockerKeyPath
