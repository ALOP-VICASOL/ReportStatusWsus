# 🛠 Reparar cliente WSUS que no reporta correctamente

Write-Host "Iniciando reparacion de cliente WSUS..." -ForegroundColor Cyan

# 1. Detener servicios de actualización
Write-Host "Deteniendo servicios..." -ForegroundColor Yellow
Stop-Service wuauserv -Force
Stop-Service bits -Force

# 2. Eliminar carpeta SoftwareDistribution (caché de actualizaciones)
Write-Host "Limpiando carpeta SoftwareDistribution..." -ForegroundColor Yellow
Remove-Item -Path "$env:windir\SoftwareDistribution" -Recurse -Force -ErrorAction SilentlyContinue

# 3. Eliminar SusClientId para forzar nueva identidad ante WSUS
Write-Host "Eliminando ID de cliente WSUS..." -ForegroundColor Yellow
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" -Name SusClientId -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" -Name SusClientIdValidation -ErrorAction SilentlyContinue

# 4. Reiniciar servicios
Write-Host "Reiniciando servicios..." -ForegroundColor Yellow
Start-Service wuauserv
Start-Service bits
Start-Sleep -Seconds 5

# 5. Forzar nuevo escaneo y reporte
Write-Host "Forzando escaneo y reporte a WSUS..." -ForegroundColor Cyan
Start-Process -FilePath "UsoClient.exe" -ArgumentList "StartScan" -NoNewWindow
Start-Sleep -Seconds 5
Start-Process -FilePath "UsoClient.exe" -ArgumentList "ReportNow" -NoNewWindow

# 6. Mostrar últimos eventos del cliente de Windows Update
Write-Host "`nEventos recientes de Windows Update:" -ForegroundColor Cyan
Get-WinEvent -LogName "System" | Where-Object { $_.ProviderName -like "Microsoft-Windows-WindowsUpdateClient" } |
    Select-Object TimeCreated, Message -First 5 | Format-List

Write-Host "`nReparacion finalizada. Revisa WSUS en unos minutos para verificar si el estado se actualizo correctamente." -ForegroundColor Green
