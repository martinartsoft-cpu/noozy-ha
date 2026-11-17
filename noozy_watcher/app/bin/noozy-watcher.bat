@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem
@rem SPDX-License-Identifier: Apache-2.0
@rem

@if "%DEBUG%"=="" @echo off
@rem ##########################################################################
@rem
@rem  noozy-watcher startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables, and ensure extensions are enabled
setlocal EnableExtensions

set DIRNAME=%~dp0
if "%DIRNAME%"=="" set DIRNAME=.
@rem This is normally unused
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and NOOZY_WATCHER_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS="-Djava.awt.headless=true" "--enable-native-access=ALL-UNNAMED"

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if %ERRORLEVEL% equ 0 goto execute

echo. 1>&2
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH. 1>&2
echo. 1>&2
echo Please set the JAVA_HOME variable in your environment to match the 1>&2
echo location of your Java installation. 1>&2

"%COMSPEC%" /c exit 1

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo. 1>&2
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME% 1>&2
echo. 1>&2
echo Please set the JAVA_HOME variable in your environment to match the 1>&2
echo location of your Java installation. 1>&2

"%COMSPEC%" /c exit 1

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\watcher-1.0.0.jar;%APP_HOME%\lib\core.jar;%APP_HOME%\lib\ui-graphics-desktop-1.12.1.jar;%APP_HOME%\lib\room-common-jvm-2.8.4.jar;%APP_HOME%\lib\room-runtime-jvm-2.8.4.jar;%APP_HOME%\lib\sqlite-jvm-2.6.2.jar;%APP_HOME%\lib\sqlite-bundled-jvm-2.6.2.jar;%APP_HOME%\lib\skiko-awt-0.150.1.jar;%APP_HOME%\lib\ui-geometry-desktop-1.12.1.jar;%APP_HOME%\lib\ui-util-desktop-1.12.1.jar;%APP_HOME%\lib\ui-unit-desktop-1.12.1.jar;%APP_HOME%\lib\runtime-desktop-1.12.1.jar;%APP_HOME%\lib\runtime-annotation-jvm-1.12.1.jar;%APP_HOME%\lib\runtime-desktop-1.12.1.jar;%APP_HOME%\lib\kotlinx-coroutines-core-jvm-1.10.2.jar;%APP_HOME%\lib\kotlinx-serialization-core-jvm-1.10.0.jar;%APP_HOME%\lib\kotlinx-serialization-json-jvm-1.10.0.jar;%APP_HOME%\lib\collection-jvm-1.5.0.jar;%APP_HOME%\lib\annotation-jvm-1.9.1.jar;%APP_HOME%\lib\kotlin-stdlib-2.3.21.jar;%APP_HOME%\lib\annotations-23.0.0.jar;%APP_HOME%\lib\core-3.5.3.jar;%APP_HOME%\lib\pdfbox-3.0.5.jar;%APP_HOME%\lib\gson-2.10.1.jar;%APP_HOME%\lib\fontbox-3.0.5.jar;%APP_HOME%\lib\pdfbox-io-3.0.5.jar;%APP_HOME%\lib\commons-logging-1.3.5.jar


@rem Execute noozy-watcher
@rem endlocal doesn't take effect until after the line is parsed and variables are expanded
@rem which allows us to clear the local environment before executing the java command
endlocal & "%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %NOOZY_WATCHER_OPTS%  -classpath "%CLASSPATH%" cz.artsoft.noozy.watcher.WatcherMainKt %* & call :exitWithErrorLevel

:exitWithErrorLevel
@rem Use "%COMSPEC%" /c exit to allow operators to work properly in scripts
"%COMSPEC%" /c exit %ERRORLEVEL%
