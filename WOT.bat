@echo off
setlocal
set version=0.2
goto :endpre

rem ------------------------------------------------------------------------
Simple batch file that checks if World of Tanks, WOT Statistics, and Active 
Dossier Uploader are running before blindly starting them.

* http://worldoftanks.com/
* http://www.vbaddict.net/wotstatistics.php
* http://www.vbaddict.net/upload.php
* http://opensource.org/licenses/MIT

### Changelog:
	0.2 	
		* Added Active Dossier Uploader
		* "Optimized" 
		* Added ability to not start a program

	0.1 Initial Release

### Known Issues:
	* Occasionaly when exiting or during a crash World of Tanks will "close"
	to background processes which will keep it from restarting.

### The MIT License (MIT)

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

rem Place WOT directory in quotes
set locationwot="D:\Games\World_of_Tanks"
rem WOT executable, no quotes
set exewot=WOTLauncher.exe

rem If you do not want to start WOT Statistics replace 1 with 0
set activestats=1
rem Place WOT Statistics directory in quotes
set locationstats="C:\Program Files (x86)\WOT Statistics 2.5" 
rem Stats executable, no quotes
set exestats=WOTStatistics.Stats.exe

rem If you do not want to start Active Dossier Uploader replace 1 with 0
set activeadu=1
rem Place Active Dossier Uploader directory in quotes
set locationadu="D:\Games\World_of_Tanks" 
rem ADU executable, no quotes
set exeadu=ActiveDossierUploader.exe

rem seconds before window closes if no errors detected
set closetime=10

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
echo ^|                        ### Version %version% ###                         ^|
echo ^|____________________________________________________________________^|
echo ^|                                                                    ^|

set olddir=%CD%

if [%closetime%]==[] set closetime=10

rem check wot directory
if not defined locationwot (
	set errors=1
	set errorlocationwot=1
	goto :errorskiplocation
)
if not exist %locationwot% (
	set errors=1
	set errorlocationwot=1
)
:errorskiplocation

rem check wot exe
if not defined exewot (
	set errors=1
	set errorexewot=1
	goto :errorskipexe
)
if defined errorlocationwot goto :errorskipexe
cd /D %locationwot%
if not exist %exewot% (
	set errors=1
	set errorexewot=1
)
:errorskipexe

rem if stats are set to active
if not %activestats%==1 goto :inactivestats
if not defined locationstats (
	set errors=1
	set errorlocationstats=1
	goto :errorskiplocation
)
if not exist %locationstats% (
	set errors=1
	set errorlocationstats=1
)
:errorskiplocation

if not defined exestats (
	set errors=1
	set errorexestats=1
	goto :errorskipexe
)
if defined errorlocationstats goto :errorskipexe
cd /D %locationstats%
if not exist %exestats% (
	set errors=1
	set errorexestats=1
)
:errorskipexe
:inactivestats

if not %activeadu%==1 goto :inactiveadu
if not defined locationadu (
	set errors=1
	set errorlocationadu=1
	goto :errorskiplocation
)
if not exist %locationadu% (
	set errors=1
	set errorlocationadu=1
)
:errorskiplocation

if not defined exeadu (
	set errors=1
	set errorexeadu=1
	goto :errorskipexe
)
if defined errorlocationadu goto :errorskipexe
cd /D %locationadu%
if not exist %exeadu% (
	set errors=1
	set errorexeadu=1
)
:errorskipexe
:inactiveadu

rem display errors
if not defined errors goto :errorfree
if defined errorlocationwot (
	echo ^|  ### Check WOT directory! ***************************************  ^|	
)
if defined errorexewot (
	echo ^|  ### Check WOT executable ***************************************  ^|
)
if defined errorlocationstats (
	echo ^|  ### Check WOT Statistics directory! ****************************  ^|
)
if defined errorexestats (
	echo ^|  ### Check WOT Statistics executable! ***************************  ^|
)
if defined errorlocationadu (
	echo ^|  ### Check Active Dossier Uploader directory! *******************  ^|
)
if defined errorexeadu (
	echo ^|  ### Check Active Dossier Uploader executable! ******************  ^|
)
echo ^|  ### Errors detected! Please repair! ****************************  ^|
echo ^|                                                                    ^|
echo ^|  --------------  Copyright ^(c^) 2014 XabstraktionX  --------------  ^|
echo ^|____________________________________________________________________^|
echo.
echo.
pause
goto :end
:errorfree

rem Lets start some stuff
tasklist /fi "imagename eq WOTLauncher.exe" |find "WOTLauncher.exe" > nul
if %errorlevel%==0 (
	set runninglauncher=1
	goto :runningwot
)
tasklist /fi "imagename eq WorldOfTanks.exe" |find "WorldOfTanks.exe" > nul
if %errorlevel%==0 (
	set runningwot=1
	goto :runningwot
)
cd /D %locationwot%
start %exewot%
:runningwot

if not %activestats%==1 goto :inactivestats
tasklist /fi "imagename eq %exestats%" |find "%exestats%" > nul
if %errorlevel%==0 (
	set runningstats=1
	goto :runningstats
)
cd /D %locationstats%
start %exestats%
:runningstats
:inactivestats

if not %activeadu%==1 goto :inactiveadu
tasklist /fi "imagename eq %exeadu%" |find "%exeadu%" > nul
if %errorlevel%==0 (
	set runningadu=1
	goto :runningadu
)
cd /D %locationadu%
start %exeadu%
:runningadu
:inactiveadu

if defined runninglauncher (
	echo ^|  ### World of Tanks Launcher Running ****************************  ^|
	goto :runningwot
)
if defined runningwot (
	echo ^|  ### World of Tanks Running *************************************  ^|
	goto :runningwot
)
echo ^|  ### World of Tanks Starting ************************************  ^|
:runningwot

if not %activestats%==1 (
	echo ^|  ### WOT Statistics Not Activated *******************************  ^|
	goto :inactivestats
)
if defined runningstats (
	echo ^|  ### WOT Statistics Running *************************************  ^|
	goto :runningstats
)
echo ^|  ### WOT Statistics Starting ************************************  ^|
:runningstats
:inactivestats

if not %activeadu%==1 (
	echo ^|  ### Active Dossier Uploader Not Activated **********************  ^|
	goto :inactiveadu
)
if defined runningadu (
	echo ^|  ### Active Dossier Uploader Running ****************************  ^|
	goto :runningadu
)
echo ^|  ### Active Dossier Uploader Starting ***************************  ^|
:runningadu
:inactiveadu

echo ^|                                                                    ^|
echo ^|  --------------  Copyright ^(c^) 2014 XabstraktionX ---------------  ^|
echo ^|____________________________________________________________________^|
echo.
echo.
chdir /d %olddir%
timeout /t %closetime% >nul
:end

exit