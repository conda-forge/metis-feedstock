MKDIR build\windows
CD build\windows

cmake -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ^
    -G "NMake Makefiles"                     ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%     ^
    -DCMAKE_BUILD_TYPE=Release               ^
    ..\..
if errorlevel 1 exit /b 1

cmake --build . --config Release
if errorlevel 1 exit /b 1

copy libmetis\metis.lib %LIBRARY_LIB%
if errorlevel 1 exit /b 1
copy programs\cmpfillin.exe %LIBRARY_BIN%
if errorlevel 1 exit /b 1
copy programs\gpmetis.exe %LIBRARY_BIN%
if errorlevel 1 exit /b 1
copy programs\graphchk.exe %LIBRARY_BIN%
if errorlevel 1 exit /b 1
copy programs\m2gmetis.exe %LIBRARY_BIN%
if errorlevel 1 exit /b 1
copy programs\ndmetis.exe %LIBRARY_BIN%
if errorlevel 1 exit /b 1
copy programs\mpmetis.exe %LIBRARY_BIN%
if errorlevel 1 exit /b 1
copy ..\..\include\metis.h %LIBRARY_INC%
if errorlevel 1 exit /b 1

CD programs
mpmetis.exe ..\..\..\graphs\metis.mesh 10
if errorlevel 1 exit 1
gpmetis.exe ..\..\..\graphs\mdual.graph 10
if errorlevel 1 exit 1
ndmetis.exe ..\..\..\graphs\mdual.graph
if errorlevel 1 exit 1
gpmetis.exe ..\..\..\graphs\test.mgraph 10
if errorlevel 1 exit 1
m2gmetis.exe ..\..\..\graphs\metis.mesh 10
if errorlevel 1 exit 1
