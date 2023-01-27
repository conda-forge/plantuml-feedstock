@ECHO ON

CALL gradlew.bat
CALL gradlew clean build pdfJar -x test

CALL echo F | xcopy .\build\libs\plantuml-pdf-*.jar %LIBRARY_LIB%\plantuml.jar

echo java -Xmx500M -jar ^%%CONDA_PREFIX^%%\Library\lib\plantuml.jar "$@" %%*> %LIBRARY_BIN%\plantuml.bat
