@ECHO ON

set MAVEN_OPTS="-Xmx1G"

cd %SRC_DIR%

call gradle tasks --all

call gradle clean build pdfJar -x test

dir build\libs

if not exist %LIBRARY_LIB% mkdir %LIBRARY_LIB%

:: outputs are usually like
:: plantuml-1.2022.1-SNAPSHOT-javadoc.jar
:: plantuml-1.2022.1-SNAPSHOT-sources.jar
:: plantuml-1.2022.1-SNAPSHOT.jar
:: plantuml-pdf-1.2022.1-SNAPSHOT.jar

:: we'd prefer the pdf one, but it has too may files for windows
del build\libs\plantuml-pdf-*.jar
del build\libs\plantuml-*-javadoc.jar
del build\libs\plantuml-*-sources.jar

copy build\libs\plantuml-*.jar "%LIBRARY_LIB%\plantuml.jar" || goto :error

if not exist %LIBRARY_BIN% mkdir %LIBRARY_BIN%

echo java -Xmx500M -jar %LIBRARY_LIB%\plantuml.jar %%* > %LIBRARY_BIN%\plantuml.cmd
echo IF %%ERRORLEVEL%% NEQ 0 EXIT /B %%ERRORLEVEL%% >> %LIBRARY_BIN%\plantuml.cmd

type %LIBRARY_BIN%\plantuml.cmd

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
