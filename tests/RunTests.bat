@echo off
::
:: CMD file to run the AutoIt tests in this directory
::
:: Copyright (c) 2008-2009 Texas Instruments, Inc.
:: Author: Martin Taylor <cmtaylor@ti.com>
::
::  Licensed under the Apache License, Version 2.0 (the "License");
::  you may not use this file except in compliance with the License.
::  You may obtain a copy of the License at
::
::      http://www.apache.org/licenses/LICENSE-2.0
::
::  Unless required by applicable law or agreed to in writing, software
::  distributed under the License is distributed on an "AS IS" BASIS,
::  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
::  See the License for the specific language governing permissions and
::  limitations under the License.
::
::-------------------------------------------------------------------------------
::
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" (
    call pybot --name "AutoItLibrary Windows Calculator" --noncritical ExpectedFAIL --outputdir .\results Win10_Calculator_Test_Cases.robot Notepad.robot
) else (
    call pybot --name "AutoItLibrary Windows Calculator" --noncritical ExpectedFAIL --outputdir .\results Calculator_Test_Cases.html Notepad.robot
)
endlocal

pause
