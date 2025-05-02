# Script para forzar reporte a WSUS (tanto en Windows 10/11)

#Escaneo de actualizaciones
Write-Host "Iniciando escaneo de actualizaciones..." -ForegroundColor Cyan
Start-Process -FilePath "UsoClient.exe" -ArgumentList "StartScan" -NoNewWindow
Start-Sleep -Seconds 5

#Reportar estado al servidor correspondiente del centro
Write-Host "Reportando estado al servidor WSUS..." -ForegroundColor Cyan
Start-Process -FilePath "UsoClient.exe" -ArgumentList "ReportNow" -NoNewWindow
Start-Sleep -Seconds 10

Write-Host "Proceso completado. Estado enviado. Puedes revisar en el servidor WSUS en unos minutos." -ForegroundColor Green

#Mostrar los últimos eventos de Windows Update del equipo
Write-Host "Últimos eventos de Windows Update:"
Get-WinEvent -LogName "System" | Where-Object { $_.ProviderName -like "Microsoft-Windows-WindowsUpdateClient" } | 
    Select-Object TimeCreated, Message -First 5 | Format-List

#❗Para ejecutar script: Set-ExecutionPolicy Bypass -Scope Process -Force & "C:\TI\reportStatusWsus.ps1"
