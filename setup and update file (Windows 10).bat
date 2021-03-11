@echo off
title SETUP
color a

mode con: cols=50 lines=8

set path=%cd%

SET /P AREYOUSURE=Are you sure you want to install (Y/[N])? 
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

md %SystemDrive%\Chriss
cd %path%
copy windows_10\Nettverk.bat %SystemDrive%\Chriss
IF errorlevel 1 (
    echo ERROR
 ) ELSE (
    copy Nettverk.lnk %USERPROFILE%"\OneDrive - Caverion Oyj\Desktop"
    IF errorlevel 1 (
        echo ERROR
        pause
     ) ELSE (
        cls
        echo ***/******************************************\***
        echo **/*************** SUCCESS! *******************\**
        echo */**********************************************\*
        echo /********* A icon is now on the desktop *********\
        echo.
        echo.
        echo.
        pause
        msg * hei
     )
 )

:END
exit