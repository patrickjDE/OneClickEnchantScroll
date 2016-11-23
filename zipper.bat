REM http://ss64.com/nt/for_f.html
for /f "delims=" %%d in ('dir /b *.toc') do set ADDONNAME=%%~nd
for /f "tokens=2,3" %%a in (%ADDONNAME%.toc) do IF "%%a"=="Version:" set VERSION=%%b

REM del %ADDONNAME%-%VERSION%.zip
cd ..

REM https://sevenzip.osdn.jp/chm/cmdline/
7z a -tzip %ADDONNAME%\%ADDONNAME%-%VERSION%.zip %ADDONNAME%\*.lua %ADDONNAME%\*.toc %ADDONNAME%\readme.md
pause