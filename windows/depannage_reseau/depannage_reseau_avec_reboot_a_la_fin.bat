REM a ex�cuter en avec les droits administrateur !! 
REM ou les droits privil�gi�s ;)
echo off
cls
ipconfig /flushdns
netsh winsock reset
netsh winhttp reset proxy
netsh winhttp reset tracing
netsh winsock reset catalog
netsh int ipv4 reset catalog
netsh int ipv6 reset catalog
shutdown -a
shutdown -r -f -t 0