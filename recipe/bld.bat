setlocal EnableDelayedExpansion

cd GKlib

mkdir build
mkdir static-libs

cd build

cmake -G "NMake Makefiles" ^
      -DCMAKE_INSTALL_PREFIX:PATH="../static-libs" ^
      -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DDEBUG=OFF ^
      -DOPENMP=set ^
      -DBUILD_SHARED_LIBS=OFF ^
      ..

if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

cmake --install .
if errorlevel 1 exit 1

cd ..
cd ..


:: See https://github.com/KarypisLab/METIS/blob/v5.1.1-DistDGL-v0.5/vsgen.bat#L3
MKDIR build\windows
MKDIR build\xinclude
COPY include\metis.h build\xinclude
COPY include\CMakeLists.txt build\xinclude
CD build\windows

cmake ^
    -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DGKLIB_PATH="../../GKlib/static-libs" ^
    ..\..

if errorlevel 1 exit 1 

:: nmake
:: if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

copy libmetis\metis.lib %LIBRARY_LIB%
copy programs\cmpfillin.exe %LIBRARY_BIN%
copy programs\gpmetis.exe %LIBRARY_BIN%
copy programs\graphchk.exe %LIBRARY_BIN%
copy programs\m2gmetis.exe %LIBRARY_BIN%
copy programs\ndmetis.exe %LIBRARY_BIN%
copy programs\mpmetis.exe %LIBRARY_BIN%
copy ..\..\include\metis.h %LIBRARY_INC%

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
