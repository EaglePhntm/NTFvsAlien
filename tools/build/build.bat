@echo off
cd %~dp0/../../ntf_modular
sort include.dm /o include2.dm
del include.dm
move include2.dm include.dm >nul
cd %~dp0
"%~dp0\..\bootstrap\node.bat" --experimental-modules "%~dp0\build.js" %*
