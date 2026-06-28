@echo off
cd %~dp0/../../ntf_modular
sort include.dm /o include2.dm
del include.dm
move include2.dm include.dm >nul
cd %~dp0/../../data
git rev-parse HEAD >revision.txt
set /p revision=<revision.txt
pushd "%temp%"
makecab /D RptFileName=~.rpt /D InfFileName=~.inf /f nul >nul
for /f "tokens=3-7" %%a in ('find /i "makecab"^<~.rpt') do (
  set "current-date=%%e-%%b-%%c"
  set "current-time=%%d"
  set "weekday=%%a"
)
del ~.*
popd
echo %current-date% %current-time% > compile_date.txt
cd %~dp0/../../_ntf_modular
echo #define DEFINE_REVINFO_REVISION "%revision%" >> revinfo.dm
echo #define DEFINE_REVINFO_COMPILE_DATE "%current-date% %current-time%" >> revinfo.dm
cd %~dp0
cmd /c ""%~dp0\..\bootstrap\node.bat" --experimental-modules "%~dp0\build.js" %*"
cd %~dp0/../../_ntf_modular
del revinfo.dm
echo //Do not edit manually >> revinfo.dm
cd %~dp0
