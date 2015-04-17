@echo off

echo BEAST directory: %BEAST_HOME%

echo Beyond Compare directory: %BEYOND_COMPARE_HOME%

set PROJECT_NAME=illustrations
echo Project name: %PROJECT_NAME%

set JOB_NAME=Illustrations
echo Jenkins job name: %JOB_NAME%

set JENKINS_JOB_UNC_SHARE=\\QDEIGOFSS01.dv.ipipenet.com\e$\jenkins\jobs\%JOB_NAME%
echo Project UNC share: %JENKINS_JOB_UNC_SHARE%

set PROJECT_UNC_SHARE=%JENKINS_JOB_UNC_SHARE%\workspace
echo Project UNC share: %PROJECT_UNC_SHARE%

set INPUT_DIR=%PROJECT_UNC_SHARE%\input
echo BEAST input directory: %INPUT_DIR%

set PROJECT_REGRESSION_OUTPUT_DIR=%PROJECT_UNC_SHARE%\baseline
echo Project regression output directory: %PROJECT_REGRESSION_OUTPUT_DIR%

set BC_SCRIPT=%JENKINS_JOB_UNC_SHARE%\workspace\illustrations_compare_script.txt
echo Beyond Compare script location: %BC_SCRIPT%

set FOLDER_DATE=%date:~7,2%-%date:~4,2%-%date:~10,4%
set FOLDER_TIME=%time:~0,2%-%time:~3,2%
set OUTPUT_DIR=%PROJECT_UNC_SHARE%\schedule\%FOLDER_DATE% %FOLDER_TIME%
echo BEAST output directory: %OUTPUT_DIR%
mkdir "%OUTPUT_DIR%"
set TESTING_ENV=QD3
echo Testing environment: %TESTING_ENV%

set TEMP_DIR=%PROJECT_UNC_SHARE%\temp

echo BEAST is running...
FOR /R "%INPUT_DIR%" %%G in (*) DO (
	echo File %%G is processing - %%~nG...
	mkdir "%TEMP_DIR%"
	copy "%%G" "%TEMP_DIR%"
	call %BEAST_HOME%\CEBatchTester.exe /input "%TEMP_DIR%" /output "%OUTPUT_DIR%" /env %TESTING_ENV% /pdf /noname
	rename "%OUTPUT_DIR%\edits.txt" "%%~nG.txt"
	rd /s /q "%TEMP_DIR%")
echo BEAST work is completed.