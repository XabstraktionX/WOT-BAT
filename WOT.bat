@echo off
goto endpre

Version .1 Initial Release

Simple batch file that checks if World of Tanks and WOT Statistics are 
running before blindly starting them both.

* http://www.vbaddict.net/wotstatistics.php
* http://worldoftanks.com/
* http://opensource.org/licenses/MIT

The MIT License (MIT)

Copyright (c) 2014 XabstraktionX https://github.com/XabstraktionX

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

:endpre

rem ------------------------------------------------------------------------
rem Edit these...

rem Place stats directory in quotes
set statslocation="C:\Program Files (x86)\WOT Statistics 2.5" 
rem Stats executable, no quotes
set statsexe=WOTStatistics.Stats.exe

rem Place WOT directory in quotes
set wotlocation="D:\Games\World_of_Tanks"
rem WOT executable, no quotes
set wotexe=WOTLauncher.exe

rem set closetime=10

rem Do not edit below this line...
rem ------------------------------------------------------------------------

color 12
echo. 
echo. 
echo  ____________________________________________________________________
echo ^|  __      __  _____   ______      ____     ______  ______   __      ^|
echo ^| /\ \  __/\ \/\  __`\/\__  _\    /\  _`\  /\  _  \/\__  _\ /\ \     ^|
echo ^| \ \ \/\ \ \ \ \ \/\ \/_/\ \/    \ \ \L\ \\ \ \L\ \/_/\ \/ \ \ \    ^|
echo ^|  \ \ \ \ \ \ \ \ \ \ \ \ \ \     \ \  _ ^<'\ \  __ \ \ \ \  \ \ \   ^|
echo ^|   \ \ \_/ \_\ \ \ \_\ \ \ \ \     \ \ \L\ \\ \ \/\ \ \ \ \  \ \_\  ^|
echo ^|    \ `\___x___/\ \_____\ \ \_\     \ \____/ \ \_\ \_\ \ \_\  \/\_\ ^|
echo ^|     '\/__//__/  \/_____/  \/_/      \/___/   \/_/\/_/  \/_/   \/_/ ^|
echo ^|                                                                    ^|
echo ^|____________________________________________________________________^|
echo ^|                                                                    ^|

set olddir=%CD%
set wotstats=0
set wotlauncher=0
set worldoftanks=0

rem error checking
rem no values
if [%closetime%]==[] set closetime=10

if not defined statslocation (
	set errors=1
	set errorstatslocation=1
)
if not defined statsexe (
	set errors=1
	set errorstatsexe=1
)
if not defined wotlocation (
	set errors=1
	set errorwotlocation=1
)
if not defined wotexe (
	set errors=1
	set errorwotexe=1
)

rem check if valid
if not defined errorstatslocation if not exist %statslocation% (
	set errors=1
	set errorstatslocation=1
)
if not defined errorstatslocation cd /D %statslocation%
if not exist %statsexe% (
	set errors=1
	set errorstatsexe=1
)
if not defined errorwotlocation if not exist %wotlocation% (
	set errors=1
	set errorwotlocation=1
)
if not defined errorwotlocation cd /D %wotlocation%
if not exist %wotexe% (
	set errors=1
	set errorwotexe=1
)

rem display errors
if defined errorstatslocation (
	echo ^|  ### Check WOTStatistics directory! *****************************  ^|
)
if defined errorstatsexe (
	echo ^|  ### Check WOTStatistics executable! ****************************  ^|
)
if defined errorwotlocation (
	echo ^|  ### Check WOT directory! ***************************************  ^|	
)
if defined errorwotexe (
	echo ^|  ### Check WOT executable ***************************************  ^|
)
if defined errors (
	echo ^|  ### Errors detected! Please repair! ****************************  ^|
	echo ^|                                                                    ^|
	echo ^|  --------------  Copyright ^(c^) 2014 XabstraktionX  --------------  ^|
	echo ^|____________________________________________________________________^|
	echo.
	echo.
	pause
	exit
)


tasklist /fi "imagename eq %statsexe%" |find "=" > nul
if errorlevel 1 (
	set wotstats=1
)
if %wotstats%==0 echo ^|  ### Stats Running **********************************************  ^|

if %wotstats%==1 (
	echo ^|  ### Stats Starting *********************************************  ^|
	cd /D %statslocation%
	start %statsexe%
)

tasklist /fi "imagename eq WOTLauncher.exe" |find "=" > nul
if errorlevel 1 (
	set wotlauncher=1
)
if %wotlauncher%==0 echo ^|  ### WOT Launcher Running ***************************************  ^|

tasklist /fi "imagename eq WorldOfTanks.exe" |find "=" > nul
if errorlevel 1 (
	set worldoftanks=1
)
if %worldoftanks%==0 echo ^|  ### WOT Running ************************************************  ^|

if %wotlauncher%==1 if %worldoftanks%==1 (
	echo ^|  ### WOT Starting ***********************************************  ^|
	cd /D %wotlocation%
	start %wotexe%
)



echo ^|                                                                    ^|
echo ^|  --------------  Copyright ^(c^) 2014 XabstraktionX ---------------  ^|
echo ^|____________________________________________________________________^|
echo.
echo.
chdir /d %olddir%
timeout /t %closetime% >nul
exit