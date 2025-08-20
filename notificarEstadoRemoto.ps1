# Nombre de la máquina remota
$remotePC =Read-Host "Nombre o IP del equipo remoto: "

# Ruta local del script en tu PC
#$localScript = "WSUS_ClientFix.ps1"
$localScript = "C:\NotificarWsus_TI\WSUS_ClientFix.ps1"

# Ruta remota donde se colocará el script
$remoteScript = "C$\temp\WSUS_ClientFix.ps1"
#$remoteScript = "C$\temp\reportStatusWsus.ps1"

# Solicita las credenciales
$cred = Get-Credential

# Copia el script a la máquina remota
Copy-Item -Path $localScript -Destination "\\$remotePC\$remoteScript" -Force

# Ejecuta el script remotamente (con política de ejecución temporal)
Invoke-Command -ComputerName $remotePC -Credential $cred -ScriptBlock {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    & "C:\temp\WSUS_ClientFix.ps1"
}

Read-Host "Presiona Enter para cerrar"
