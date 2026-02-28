@ECHO ON

CALL ant -noinput                                                                               || exit 2

IF NOT EXIST "%LIBRARY_LIB%" mkdir "%LIBRARY_LIB%"                                              || exit 3
IF NOT EXIST "%LIBRARY_BIN%" mkdir "%LIBRARY_BIN%"                                              || exit 4

CALL echo F | xcopy plantuml.jar "%LIBRARY_LIB%\plantuml.jar"                || exit 5

ECHO java -Xmx500M -jar %LIBRARY_LIB%\plantuml.jar "$@"     %%*> %LIBRARY_BIN%\plantuml.bat     || exit 6
ECHO IF %%ERRORLEVEL%% NEQ 0 EXIT /B %%ERRORLEVEL%%         >> %LIBRARY_BIN%\plantuml.bat       || exit 7

ECHO "----------------------- generated wrapper script ------------------------"
TYPE "%LIBRARY_BIN%\plantuml.bat"
ECHO "-------------------------------------------------------------------------"
