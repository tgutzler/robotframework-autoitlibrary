AutoItLibrary
=============

Introduction
------------

AutoItLibrary is a Python keyword library that extends Robot Framework
(http://robotframework.org/) by providing keywords based on the
COM interface to AutoIt (https://www.autoitscript.com/site/autoit/).
AutoIt is a freeware tool for automating the Windows GUI.

In order to do screenshots, the AutoItLibrary uses "The friendly PIL fork"
pillow: https://python-pillow.org/.

Installation
------------

AutoItLibrary installs its own file and, if not already present, the 3rd party
AutoIt. The pillow tools are optional and must be installed separately if
screenshots are required. To install, unzip the release file into a temporary
directory on your PC, open a command window in that directory and type:

    python setup.py install

This installation creates the folder:

   C:\RobotFramework\Extensions\AutoItLibrary

on your PC and puts various files into this directory folder.


Documentation
-------------

AutoItLibrary documentation is installed by the installation process into

    C:\RobotFramework\Extensions\AutoItLibrary\AutoItLibrary.html

The AutoItX documentation is also installed into this folder as AutoItX.chm.


Tests
-----

The AutoItLibrary installer puts a suite of self-tests here:

    C:\RobotFramework\Extensions\AutoItLibrary\tests

To run these tests, which exercise the Windows Calculator GUI, run the
RunTests.bat file in the above folder.

-------------------------------- End of file --------------------------------
