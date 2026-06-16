@echo off
cd %~dp0/../../ntf_modular
sort include.dm /o include2.dm
del include.dm
move include2.dm include.dm >nul
cd %~dp0/../../data
git rev-parse HEAD >revision.txt
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
cd %~dp0
"%~dp0\..\bootstrap\node.bat" --experimental-modules "%~dp0\build.js" %*
