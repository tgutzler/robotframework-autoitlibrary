*** Settings ***
Suite Setup    Start Calculator            
Suite Teardown    Stop Calculator            
Test Setup    Clear            
Library    AutoItLibrary    ${OUTPUTDIR}    10    ${True}
Library    Collections            
Library    String            
Library    Process

*** Variables ***

*** Test Cases ***
Integer Addition
    [Documentation]    Get "The Answer" by addition.
    Send    41{+}1{ENTER}
    ${Ans} =    Get Answer
    Should Be Equal As Numbers    ${Ans}    42

Integer Subtraction
    [Documentation]    Get "The Answer" by subtraction.
    Send    45-3{ENTER}        
    ${Ans} =    Get Answer        
    Should Be Equal As Numbers    ${Ans}    42    

Integer Multiplication
    [Documentation]    Get "The Answer" by multiplication.
    Send    6*7{ENTER}        
    ${Ans} =    Get Answer        
    Should Be Equal As Numbers    ${Ans}    42    

Integer Division
    [Documentation]    Get "The Answer" by division.
    Send    546/13{ENTER}        
    ${Ans} =    Get Answer        
    Should Be Equal As Numbers    ${Ans}    42    

Hex Addition
    [Documentation]    Test Hex addition.
    [Setup]    Set Hex Mode        
    Send    DE01F100        
    Send    {+}        
    Send    ABCDEF        
    Send    {ENTER}        
    ${Ans} =    Get Answer        
    Should Be Equal As Strings    ${Ans}    DEADBEEF    

Hex Subtraction
    [Documentation]    Test Hex subtraction.
    [Setup]    Set Hex Mode        
    Clip Put    DF598CDE        
    Sleep    0.1 sec
    Send    ^v        
    Send    -        
    Clip Put    ABCDEF        
    Sleep    0.1 sec
    Send    ^v        
    Send    {ENTER}        
    ${Ans} =    Get Answer        
    Should Be Equal As Strings    ${Ans}    DEADBEEF    

Test Screen Capture On FAIL
    [Documentation]    Test that a screenshot is taken and included in the report file when an AutoItLibrary keyword fails. This test will always fail.
    [Tags]    ExpectedFAIL        
    [Setup]    Set Hex Mode        
    Send    DE01F100        
    Send    {+}        
    Send    ABCDEF        
    Send    {ENTER}        
    Wait For Active Window    Calculator    stuffup    1

*** Keywords ***
Start Calculator
    [Documentation]    Start the Windows Calculator application and set the default settings that the rest of the tests expect.
    Run    calc.exe        
    Wait For Active Window    Calculator
    Send    !2
    Send    {F3}        
    Comment    We want "Digit Grouping" off but there's no way to examine the check beside the menu item. So we need to try recognizing some displayed digits to see if its on or off and then change it if necessary.        
    Send    123
    ${Ans}=    Get Answer        
    Should Be Equal As Numbers    ${Ans}    123
    Clear            

Stop Calculator
    [Documentation]    Shut down the Windows Calculator application.
    Win Activate    Calculator        
    Send    !{F4}        

Click Button
    [Arguments]    ${ButtonText}        
    [Documentation]    Click a button by its text name, using the Calculator GUI Map.
    ${ButtonName} =    Get From Dictionary    ${GUIMAP}    ${ButtonText}
    Control Click    Calculator    ${EMPTY}    ${ButtonName}

Set Hex Mode
    [Documentation]    Put the calculator in Hex arithmetic Dword mode.
    Send    !3        
    Send    {F2}        
    Send    {F5}        
    Sleep    1 sec        

Get Answer
    [Documentation]    Get the answer via the clipboard
    Send    ^c
    ${Answer} =    Clip Get        
    [Return]    ${Answer}        

Clear
    [Documentation]    Select CE
    Win Activate    Calculator        
    Send    {DEL}