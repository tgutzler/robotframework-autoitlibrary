"""
Package: robotframework-AutoItLibrary
Module:  AutoItLibrary Installation Module
Purpose: This is a Python "Distutils" setup program used to build installers for and to install the
         robotframework-AutoItLibrary.

         Copyright (c) 2008-2010 Texas Instruments, Inc.

         Licensed under the Apache License, Version 2.0 (the "License");
         you may not use this file except in compliance with the License.
         You may obtain a copy of the License at

             http://www.apache.org/licenses/LICENSE-2.0

         Unless required by applicable law or agreed to in writing, software
         distributed under the License is distributed on an "AS IS" BASIS,
         WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
         See the License for the specific language governing permissions and
         limitations under the License.
"""
__author__  = "Martin Taylor <cmtaylor@ti.com>"

from distutils.core      import setup
from distutils.sysconfig import get_python_lib
import sys
import os
import platform
import shutil
import subprocess

CLASSIFIERS = """
Development Status :: 5 - Production/Stable
License :: OSI Approved :: Apache Software License
Operating System :: Microsoft :: Windows
Programming Language :: Python
Topic :: Software Development :: Testing
"""[1:-1]

DESCRIPTION = """
AutoItLibrary is a Robot Framework keyword library wrapper for for the
freeware AutoIt tool (https://www.autoitscript.com/site/autoit/)
using AutoIt's AutoItX.dll COM object. The AutoItLibrary class
provides a proxy for the AutoIt keywords callable on the AutoIt COM
object and provides additional high-level keywords implemented as
methods in this class.
"""[1:-1]

if __name__ == "__main__":
    #
    # Install the 3rd party packages
    #
    if sys.argv[1].lower() == "install" :
        if os.name == "nt" :
            #
            # Make sure we have win32com installed
            #
            try:
                from win32com.shell import shell
            except:
                print("AutoItLibrary requires pywin32. See https://sourceforge.net/projects/pywin32/files/pywin32/.")
                sys.exit(2)

            #
            # Make sure we are admin
            #
            if not shell.IsUserAnAdmin():
                print("The setup script needs to be run as administrator to be able to register the COM Objects")
                sys.exit(2)

            #
            # Pick the right bitness dll
            #
            if (platform.architecture()[0] == "32bit"):
                dllFile = "AutoItX3.dll"
            else:
                dllFile = "AutoItX3_x64.dll"

            #
            # Install and register AutoItX
            #
            print("Registering AutoItX dll")
            instDir = os.path.normpath(os.path.join(get_python_lib(), "AutoItLibrary/lib"))
            if not os.path.isdir(instDir) :
                os.makedirs(instDir)
            instFile = os.path.normpath(os.path.join(instDir, dllFile))
            scriptDir = os.path.dirname(os.path.realpath(sys.argv[0]))
            shutil.copyfile(scriptDir + "\\3rdPartyTools\\AutoIt\\" + dllFile, instFile)
            #
            # Register the AutoItX COM object
            # and make its methods known to Python
            #
            os.chdir(instDir)
            cmd = r"%SYSTEMROOT%\system32\regsvr32.exe /S " + dllFile
            print(cmd)
            subprocess.check_call(cmd, shell=True)
            makepy = os.path.normpath(os.path.join(get_python_lib(), "win32com/client/makepy.py"))

            cmd = "python \"%s\" %s" % (makepy, dllFile)
            print(cmd)
            subprocess.check_call(cmd)
        else :
            print("AutoItLibrary cannot be installed on non-Windows platforms.")
            sys.exit(2)
    #
    # Figure out the install path
    #
    destPath = os.path.normpath(os.path.join(os.getenv("HOMEDRIVE"), r"\RobotFramework\Extensions\AutoItLibrary"))
    #
    # Do the distutils installation
    #
    os.chdir(scriptDir)
    setup(name         = "AutoItLibrary",
          version      = "1.2",
          description  = "AutoItLibrary for Robot Framework",
          author       = "Martin Taylor",
          author_email = "cmtaylor@ti.com",
          url          = "https://github.com/CMTaylor/robotframework-autoitlibrary",
          license      = "Apache License 2.0",
          platforms    = "Microsoft Windows",
          classifiers  = CLASSIFIERS.splitlines(),
          long_description = DESCRIPTION,
          package_dir  = {'' : "src"},
          packages     = ["AutoItLibrary"],
          data_files   = [(destPath,
                             ["ReadMe.txt",
                              "COPYRIGHT.txt",
                              "LICENSE.txt",
                              "doc/AutoItLibrary.html",
                              "3rdPartyTools/AutoIt/Au3Info.exe" if platform.architecture()[0] == "32bit" else "3rdPartyTools/AutoIt/Au3Info_x64.exe",
                              "3rdPartyTools/AutoIt/AutoItX.chm",
                              "3rdPartyTools/AutoIt/AutoIt_License.html"
                             ]),
                           (os.path.join(destPath, "tests"),
                             ["tests/CalculatorGUIMap.py",
                              "tests/__init__.html",
                              "tests/Calculator_Test_Cases.html",
                              "tests/Win10_Calculator_Test_Cases.robot",
                              "tests/RobotIDE.bat",
                              "tests/RunTests.bat"
                             ]),
                         ]
         )
#
# -------------------------------- End of file --------------------------------
