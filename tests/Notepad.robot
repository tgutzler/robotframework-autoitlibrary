*** Settings ***
Suite Setup    Start Notepad
Suite Teardown    Stop Notepad
Test Setup    Clear            
Library    AutoItLibrary    ${OUTPUTDIR}    10    ${True}
Library    Collections
Library    String
Library    Process

*** Variables ***

*** Test Cases ***
Paste Question
    [Documentation]    Ask the question
    Auto It Set Option    SendKeyDelay    40
    Send     What is the answer to the Ultimate Question of Life, the Universe, and Everything?{ENTER}
    Should Be Equal As Numbers    42    42

Find Answer
    [Documentation]    Answer the question
    Auto It Set Option    SendKeyDelay    1000
    Send    ^a
    Send    42
    Auto It Set Option    SendKeyDelay    10
    Send    ^a^c
    Send    {DOWN}
    ${Ans} =    Get Text
    Should Be Equal As Numbers    ${Ans}    42
    
*** Keywords ***
Start Notepad
    [Documentation]    Start the Windows Notepad application.
    Start Process    notepad.exe
    Wait For Active Window    Untitled - Notepad

Stop Notepad
    [Documentation]    Shut down the Windows Notepad application.
    Win Activate    Untitled - Notepad
    Send    ^a{DEL}
    Send    !{F4}

Get Text
    [Documentation]    Get the text via the clipboard
    Win Activate    Untitled - Notepad
    Send    ^c
    ${Answer} =    Clip Get
    [Return]    ${Answer}

Clear
    [Documentation]    Delete all text
    Win Activate    Untitled - Notepad
    Send    ^a
    Send    {DEL}
