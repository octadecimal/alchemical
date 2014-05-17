:user_configuration

:: About AIR application packaging
:: http://livedocs.adobe.com/flex/3/html/help.html?content=CommandLineTools_5.html#1035959
:: http://livedocs.adobe.com/flex/3/html/distributing_apps_4.html#1037515

:: NOTICE: all paths are relative to project root

echo Setting up application...
echo Application XML: %APP_XML%
echo Application DIR: %APP_DIR%

:: Your certificate information
set CERT_NAME="AlchemicalClient"
set CERT_PASS=fd
set CERT_FILE="AlchemicalClient.p12"
set SIGNING_OPTIONS=-storetype pkcs12 -keystore %CERT_FILE% -storepass %CERT_PASS%

:: Application descriptor

:: Files to package
set FILE_OR_DIR=-C %APP_DIR% .

:: Your application ID (must match <id> of Application descriptor)
set APP_ID=alchemical.client.Alchemical

:: Output
set AIR_PATH=../air
set AIR_NAME=AlchemicalOnline

:validation
%SystemRoot%\System32\find /C "<id>%APP_ID%</id>" "%APP_XML%" > NUL
if errorlevel 1 goto badid
goto end

:badid
echo.
echo ERROR: 
echo   Application ID in 'bat\SetupApplication.bat' (APP_ID) 
echo   does NOT match Application descriptor '%APP_XML%' (id)
echo.
if %PAUSE_ERRORS%==1 pause
exit

echo Application setup.

:end

echo Application setup.
