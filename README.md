
# Reportar estado WSUS
Fuerza a buscar actualizaciones y a reportar el estado al servidor wsus pertinente. 

## notificarEstadoRemoto.ps1

- Si se necesita usar de forma remota hay que utilizar este script. Se introduce el nombre del equipo ___(previamente con WinRM habilitado)___ y dejar que haga su magia. Por defecto usa ___WSUS_ClientFix.ps1___ como script para notificar, ya que es una versión más reciente y robusta que ___reportStatusWsus.ps1___

## reportStatusWsus.ps1
- Una versión más básica y primeriza, lo subo para que no quede en el olvido.

## WSUS_ClientFix.ps1
- Este script es el más completo y funcional. Hace lo siguiente:
    1. Detiene los servicios *wuauserv*.
    2. Elimina la carpeta SoftwareDistribution (donde se almacena la caché de las actualizaciones).
    3. Elimina el ID del cliente WSUS (Con esto se fuerza una nueva identidad ante el WSUS).
    4. Reinicia los servicios *wuauserv*.
    5. Fuerza el escaneo de actualizaciones y el reporte al servidor.
    6. Genera en la misma consola los eventos recientes de Windows Update.



![Logo](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDN1fFLq98SmIX1Clf8Lba31XX9cBMFWLXtQ&s)

