@echo off
mode con: cols=70 lines=8
color a
title Nettverk
 
set adapter="Ethernet"
set mask=255.255.255.0
set gw=
set ip=
 
:ip
set /P ip_ipv4="skriv inn ip: "
 
IF [%ip_ipv4%] == [] (
    mode con: cols=70 lines=8
    cls
    echo Du skrev ikke noe
    goto ip
)
 
 
IF %ip_ipv4% ==help goto help
 
IF %ip_ipv4% ==exit (
    exit
)
 
mode con: cols=70 lines=8
 
 
IF %ip_ipv4% ==cls (
    cls
    goto ip
)
IF %ip_ipv4% ==clear (
    cls
    goto ip
)
 
IF %ip_ipv4% ==gateway (
    set ip_ipv4=
    set /P gw="Endre gateway: "
    IF NOT "%ip%" == "" goto setip
    goto ip
)
IF %ip_ipv4% ==gw (
    set ip_ipv4=
    set /P gw="Endre gateway: "
    IF NOT "%ip%" == "" goto setip
    goto ip
)
 
IF %ip_ipv4% ==mask (
    set ip_ipv4=
    set /P mask="Endre maske: "
    IF NOT "%ip%" == "" goto setip
    goto ip
)
IF %ip_ipv4% ==dhcp (
    netsh int ip set address name = %adapter% source = dhcp
    IF errorlevel 1 (
        cls
        echo fikk ikke satt til DHCP
        echo test conection to the adapter %adapter%
        echo or DHCP is alredy active
     ) ELSE (
        cls
        echo DHCP er aktiv
     )
    goto ip
) ELSE (
    set ip= %ip_ipv4%
    goto setip
)
 
 
 
:setip
echo.
echo Endrer %adapter% ipv4 til: %ip%
netsh interface ip set address %adapter% static %ip% %mask% %gw%
IF errorlevel 1 (
    echo Unsuccessfull. try "help"
    set ip_ipv4=
) ELSE (
   
    echo SUCCESS!
    echo IPv4:   %ip%
    echo maske:   %mask%
    echo gateway: %gw%
    echo.
)
goto ip
 
:help
mode con: cols=36 lines=19
cls
 
echo Eksempler / help
echo ___________________________________
echo.
echo [IPv4] eks.(192.168.0.50)
echo.
echo mask [return] input ny maske.
echo Default maske er 255.255.255.0
echo.
echo gateway [return] input ny gateway
echo Deafault er NULL.
echo.
echo cls eller clear [return] fjerner
echo alt i vunduet.
echo.
echo exit [return] stopper og avslutter.
echo.
echo ___________________________________
echo.
set ip_ipv4=
goto ip
