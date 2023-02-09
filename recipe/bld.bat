@ECHO ON

CALL gradlew.bat
CALL gradlew clean build pdfJar -x test

CALL if not exist %LIBRARY_LIB% mkdir %LIBRARY_LIB%

CALL echo F | xcopy .\build\libs\plantuml-pdf-*.jar %LIBRARY_LIB%\plantuml.jar || goto :error

if not exist %LIBRARY_BIN% mkdir %LIBRARY_BIN%

echo java -Xmx500M -jar %LIBRARY_LIB%\plantuml.jar "$@" %%*> %LIBRARY_BIN%\plantuml.bat
echo IF %%ERRORLEVEL%% NEQ 0 EXIT /B %%ERRORLEVEL%% >> %LIBRARY_BIN%\plantuml.bat

type %LIBRARY_BIN%\plantuml.bat

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
