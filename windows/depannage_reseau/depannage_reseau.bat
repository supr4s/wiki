REM a exécuter en avec les droits administrateur !! 
REM ou les droits privilégiés ;)
echo off
cls
ipconfig /flushdns
netsh winsock reset
netsh winhttp reset proxy
netsh winhttp reset tracing
netsh winsock reset catalog
netsh int ipv4 reset catalog
netsh int ipv6 reset catalog
:debut
echo *********************************************************************
echo ***********Il va falloir maintenant redemarrer l'ordinateur**********
echo **********Attention aux travaux en cours et non-enregistres**********
echo *********************************************************************
set /p restart=*****Le redemarrer ? Tapez oui/non*****
(
if %restart%==oui goto restart_computer
if %restart%==non goto end
)
echo %restart% n'est pas un parametre valide !
goto debut
:restart_computer
echo Redemarrage de l'ordinateur...
shutdown -a
shutdown -r -f -t 0
goto end
:end
