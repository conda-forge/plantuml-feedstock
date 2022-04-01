@ECHO ON

set MAVEN_OPTS="-Xmx1G"

cd %SRC_DIR%

gradle -q clean build pdfJar -x test -x lint

if not exist %LIBRARY_LIB% mkdir %LIBRARY_LIB%

copy build\libs\plantuml-pdf-*.jar "%LIBRARY_LIB%\plantuml-pdf.jar" || goto :error

if not exist %LIBRARY_BIN% mkdir %LIBRARY_BIN%

echo java -Xmx500M -jar %LIBRARY_LIB%\plantuml-pdf.jar %%* > %LIBRARY_BIN%\plantuml.cmd
echo IF %%ERRORLEVEL%% NEQ 0 EXIT /B %%ERRORLEVEL%% >> %LIBRARY_BIN%\plantuml.cmd

type %LIBRARY_BIN%\plantuml.cmd

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
