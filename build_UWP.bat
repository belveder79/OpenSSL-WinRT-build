@echo off
pushd %~dp0
set bits=%1
set bits2=%2
rem This is for the nightly build server where multiple VS are installed
call "%VS140COMNTOOLS%..\..\..\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" %bits% store

cd %~dp0

IF "%bits%"=="x86" (
  msbuild openSSL.sln /t:NT-Universal-10_0-Static-Unicode /p:Configuration=Release;Platform=x86
  if not %ERRORLEVEL% == 0 goto Finish
)

IF "%bits%"=="x64" (
  msbuild openSSL.sln /t:NT-Universal-10_0-Static-Unicode /p:Configuration=Release;Platform=x64
  if not %ERRORLEVEL% == 0 goto Finish
)

IF "%bits%"=="x86_arm" (
  msbuild openSSL.sln /t:NT-Universal-10_0-Static-Unicode /p:Configuration=Release;Platform=ARM
  if not %ERRORLEVEL% == 0 goto Finish
)

echo #### Building OpenSSL done!

:Finish
popd
