@echo off

:: Author: Helberth Espindola
:: This file create an installer

:: create dates variables
set year=%date:~10,4%
set month=%date:~4,2%
set day=%date:~7,2%
set current_time=%time:~0,2%%time:~3,2%%time:~6,2%

::Get name and version values from version.txt file
for /f "delims== tokens=1,2" %%G in (version.txt) do (
	if %%G==name set name=%%H
	if %%G==version set version=%%H
)
	
echo name: %name%
echo version: %version%

:: create directory name variable
::set directory=Installer_%month%-%year%-%day%_%current_time%
set directory=Releases\Installer_%name%_%month%_%year%_%day%
echo %directory%

:: create directory hierarchy
md %~dp0%directory%\Package

:: copy Package folder to new directory
Robocopy %~dp0\Package %~dp0\%directory%\Package /E 
copy %~dp0\Installation_Instructions.txt %~dp0\%directory%
copy %~dp0\installer.bat %~dp0\%directory%
copy %~dp0\Releases.txt %~dp0\%directory%

PAUSE