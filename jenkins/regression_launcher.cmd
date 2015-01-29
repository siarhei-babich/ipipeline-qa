@echo off

set BEAST_HOME=E:\beast\BEAST_5.7
echo BEAST directory: %BEAST_HOME%
set BEYOND_COMPARE_HOME=C:\Program Files (x86)\Beyond Compare 4
echo Beyond Compare directory: %BEYOND_COMPARE_HOME%
set INPUT_DIR=E:\epam\ps\aig\auto\cebatchtool\input
echo BEAST input directory: %INPUT_DIR%

set PROJECT_REGRESSION_OUTPUT_DIR=E:\epam\ps\aig\auto\cebatchtool\baseline
echo Project regression output directory: %PROJECT_REGRESSION_OUTPUT_DIR%
set BC_SCRIPT=%cd%\agla_compare_script.txt
echo Beyond Compare script location: %BC_SCRIPT%

set FOLDER_DATE=%date:~7,2%-%date:~4,2%-%date:~10,4%
set FOLDER_TIME=%time:~0,2%-%time:~3,2%
set OUTPUT_DIR=%cd%\schedule\%FOLDER_DATE% %FOLDER_TIME%
echo BEAST output directory: %OUTPUT_DIR%
mkdir "%OUTPUT_DIR%"

echo BEAST is running...
%BEAST_HOME%\CEBatchTester.exe /input "%INPUT_DIR%" /output "%OUTPUT_DIR%" /server igoforms-app-ta1.dv.ipipenet.com /pdf /noname
echo BEAST work is completed.

set BC_COMPARE_LOG=%cd%\logs\%FOLDER_DATE% %FOLDER_TIME% BC log.txt

set BC_COMPARE_REPORT_DIR=%cd%\reports\%BUILD_NUMBER%
mkdir "%BC_COMPARE_REPORT_DIR%"
echo Beyond compare report location: %BC_COMPARE_REPORT_DIR%

FOR /F "delims=" %%i IN ('dir "%PROJECT_REGRESSION_OUTPUT_DIR%" /b /ad-h /t:c /o-d') DO (
    SET BASELINE_DIR=%PROJECT_REGRESSION_OUTPUT_DIR%\%%i
    GOTO :found
)
echo No subfolders were found under %PROJECT_REGRESSION_OUTPUT_DIR%.
goto :eof
:found
echo Baseline directory (the most recent subfolder): %BASELINE_DIR%

echo Beyond Compare is running...
"%BEYOND_COMPARE_HOME%\BComp.com" /silent "@%BC_SCRIPT%" "%OUTPUT_DIR%" "%BASELINE_DIR%" "%BC_COMPARE_REPORT_DIR%\report.html"
echo Beyond Compare work is completed.