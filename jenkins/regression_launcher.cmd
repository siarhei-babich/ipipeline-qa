@echo off

echo BEAST directory: %BEAST_HOME%

echo Beyond Compare directory: %BEYOND_COMPARE_HOME%

set PROJECT_NAME=sammons\na
echo Project name: %PROJECT_NAME%

echo Jenkins job name: %JOB_NAME%

set PROJECT_UNC_SHARE=\\QDEIGOFSS01.dv.ipipenet.com\epam\ps\%PROJECT_NAME%\auto\cebatchtool
echo Project UNC share: %PROJECT_UNC_SHARE%

set JENKINS_JOB_UNC_SHARE=\\QDEIGOFSS01.dv.ipipenet.com\e$\jenkins\jobs\%JOB_NAME%
echo Project UNC share: %JENKINS_JOB_UNC_SHARE%

set INPUT_DIR=%PROJECT_UNC_SHARE%\input
echo BEAST input directory: %INPUT_DIR%

set PROJECT_REGRESSION_OUTPUT_DIR=%PROJECT_UNC_SHARE%\baseline
echo Project regression output directory: %PROJECT_REGRESSION_OUTPUT_DIR%

set BC_SCRIPT=%JENKINS_JOB_UNC_SHARE%\workspace\sammons_na_compare_script.txt
echo Beyond Compare script location: %BC_SCRIPT%

set FOLDER_DATE=%date:~7,2%-%date:~4,2%-%date:~10,4%
set FOLDER_TIME=%time:~0,2%-%time:~3,2%
set OUTPUT_DIR=%PROJECT_UNC_SHARE%\schedule\%FOLDER_DATE% %FOLDER_TIME%
echo BEAST output directory: %OUTPUT_DIR%
mkdir "%OUTPUT_DIR%"
set TESTING_ENV=QD4
echo Testing environment: %TESTING_ENV%

echo BEAST is running...
%BEAST_HOME%\CEBatchTester.exe /input "%INPUT_DIR%" /output "%OUTPUT_DIR%" /env %TESTING_ENV% /pdf /noname
echo BEAST work is completed.

set BC_COMPARE_LOG=%JENKINS_JOB_UNC_SHARE%\workspace\logs\%FOLDER_DATE% %FOLDER_TIME% BC log.txt

set BC_COMPARE_REPORT_DIR=%JENKINS_JOB_UNC_SHARE%\workspace\reports\%BUILD_NUMBER%
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
"%BEYOND_COMPARE_HOME%\BComp.com" /silent "@%BC_SCRIPT%" "%OUTPUT_DIR%" "%BASELINE_DIR%" "%BC_COMPARE_REPORT_DIR%\Folder Compare Report.html"
echo Beyond Compare work is completed.