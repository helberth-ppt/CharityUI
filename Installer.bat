REM Authors: Gonzalo Munoz, Eduardo Toledo
REM This installer makes the following actions: 
REM  1. A backup up in the a  folder BKP of the following items:
REM         Base\java\lib
REM         Base\dotnet\bin
REM         Base\Conf\Properties
REM         Base\GUIAPP\content\config
REM         Base\GUIAPP\content_softkey\views
REM         Base\GUIAPP\content_softkey\views\scripts
REM         Base\GUIAPP\content_softkey\views\style\default\default\default
REM 		Base\GUIAPP\content_softkey\views\style\default\images\
REM 		Base\GUIAPP\content_softkey\viewmodels\
REM         Base\bin\
REM  2. A folder Package that is the source of the new files to be installed  must have the following structure:   
REM        Package\java
REM        Package\dotnet
REM        Package\json
REM        Package\properties
REM        Package\reg
REM        Package\script
REM        Package\style
REM        Package\views
REM        Package\images
REM        Package\ViewModel
REM        Package\bin
REM   Important: %~dp0 : It respresent the current working folder

rem @echo off
set CURRENT_DATE=%date:~10,4%%date:~4,2%%date:~7,2%%time:~0,2%%time:~3,2%%time:~6,2%
set CURRENT_DATE=%CURRENT_DATE: =0%
echo Current date %CURRENT_DATE%.........>> %~dp0\installation_%CURRENT_DATE%.log 
echo Log path %~dp0\installation_%CURRENT_DATE%.log ......... >> %~dp0\installation_%CURRENT_DATE%.log 

call:FilesBackUp
call:RegBackup
call:FilesInstallation
call:RegImport
goto:eof

::--------------------------------------------------------
::-- FilesBackUp
::--------------------------------------------------------
:FilesBackUp
echo ............Creating Rollback files.........>> %~dp0\installation_%CURRENT_DATE%.log 
md %~dp0\BKP_%CURRENT_DATE%
md %~dp0\BKP_%CURRENT_DATE%\java
echo ............Backing jar Files up.........>> %~dp0\installation_%CURRENT_DATE%.log  2>&1
copy c:\ProFlex4\Base\Java\lib\*.jar %~dp0\BKP_%CURRENT_DATE%\java\*.* >> %~dp0\installation_%CURRENT_DATE%.log  2>&1
md %~dp0\BKP_%CURRENT_DATE%\dotnet
echo ..........Backing dotnet Files up......... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy c:\ProFlex4\Base\dotnet\bin\*.dll %~dp0\BKP_%CURRENT_DATE%\dotnet\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
md %~dp0\BKP_%CURRENT_DATE%\properties
echo .........Backing properties up......... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy C:\ProFlex4\Base\Conf\properties\PROPERTY*.xml %~dp0\BKP_%CURRENT_DATE%\properties\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
md %~dp0\BKP_%CURRENT_DATE%\json
echo .........Backing GUIAPP\content\config up......... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy C:\ProFlex4\Base\GUIAPP\content\config\*.json %~dp0\BKP_%CURRENT_DATE%\json\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
md %~dp0\BKP_%CURRENT_DATE%\views
echo ........Backing views up......... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy C:\ProFlex4\Base\GUIAPP\content_softkey\views\*.html %~dp0\BKP_%CURRENT_DATE%\views\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
md %~dp0\BKP_%CURRENT_DATE%\script
echo .......Backing Scripts up....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy C:\ProFlex4\Base\GUIAPP\content_softkey\views\script\*.js %~dp0\BKP_%CURRENT_DATE%\script\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
md %~dp0\BKP_%CURRENT_DATE%\style
echo .......Backing Styles up....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy C:\ProFlex4\Base\GUIAPP\content_softkey\views\style\default\default\default\*.css %~dp0\BKP_%CURRENT_DATE%\style\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
md %~dp0\BKP_%CURRENT_DATE%\images
echo .......Backing Images up....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy C:\ProFlex4\Base\GUIAPP\content_softkey\views\style\default\images\*.svg %~dp0\BKP_%CURRENT_DATE%\images\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
md %~dp0\BKP_%CURRENT_DATE%\viewmodel
echo .......Backing ViewModel up....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy C:\ProFlex4\Base\GUIAPP\content_softkey\viewmodels\*.js %~dp0\BKP_%CURRENT_DATE%\viewmodel\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
md %~dp0\BKP_%CURRENT_DATE%\bin
echo .......Backing BaseBin up....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy c:\ProFlex4\Base\bin\*.dll %~dp0\BKP_%CURRENT_DATE%\bin\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
md %~dp0\BKP_%CURRENT_DATE%\services
echo .......Backing Services up....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy C:\ASAI\Services\MFKASAILOSvc\*.* %~dp0\BKP_%CURRENT_DATE%\services\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
goto:eof

:RegBackup
md %~dp0\BKP_%CURRENT_DATE%\reg
echo .......Exporting Registry ....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
rem REG EXPORT "HKLM\Software\WOW6432Node\Wincor Nixdorf" %~dp0\BKP_%CURRENT_DATE%\reg\PF4.reg >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
REG EXPORT "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Wincor Nixdorf\ProTopas\CurrentVersion" %~dp0\BKP_%CURRENT_DATE%\reg\PF4Backup.reg >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
goto:eof

:FilesInstallation
echo ............Installation.........>> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ............Installing jar Files.........>> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\java\*.jar c:\ProFlex4\Base\Java\lib\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing dotnet Files.........>> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\dotnet\*.dll c:\ProFlex4\Base\dotnet\bin\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing properties.........>> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\properties\*.xml C:\ProFlex4\Base\Conf\properties\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing GUIAPP\Content\Config.........>> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\json\*.json C:\ProFlex4\Base\GUIAPP\content\config\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing views......... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\views\*.html C:\ProFlex4\Base\GUIAPP\content_softkey\views\*.*  >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing Scripts....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\script\*.js C:\ProFlex4\Base\GUIAPP\content_softkey\views\script\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing Styles....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\style\*.css C:\ProFlex4\Base\GUIAPP\content_softkey\views\style\default\default\default\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing images....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\images\*.svg C:\ProFlex4\Base\GUIAPP\content_softkey\views\style\default\images\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing viewmodel....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\viewmodel\*.js C:\ProFlex4\Base\GUIAPP\content_softkey\viewmodels\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing Basebin Files.........>> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\bin\*.dll c:\ProFlex4\Base\bin\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing Services Files.........>> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\services\*.* C:\ASAI\Services\MFKASAILOSvc\*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
echo ...........Installing Machine scripts.........>> %~dp0\installation_%CURRENT_DATE%.log 2>&1
copy /Y %~dp0\Package\machine_scripts\*.* "C:\Program Files\Diebold\Agilis Empower\Tools\Scripts\"*.* >> %~dp0\installation_%CURRENT_DATE%.log 2>&1

goto:eof

:RegImport
echo ......Importing Registry....... >> %~dp0\installation_%CURRENT_DATE%.log 2>&1
rem for /r %%i in (%~dp0\Package\Reg\*.reg) >> %~dp0\installation_%CURRENT_DATE%.log 2>&1 do ( echo %%i REG IMPORT %%i >> %~dp0\installation_%CURRENT_DATE%.log 2>&1)
for /r  %~dp0\Package\Reg %%i in (*.reg) do ( reg import %%i >> %~dp0\installation_%CURRENT_DATE%.log 2>&1 )
goto:eof
