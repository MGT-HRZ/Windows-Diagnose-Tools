cls

@echo off

Title Windows Component Checker

:menu
echo.
echo Choose an option:
echo 1. Windows CPU Finder
echo 2. Windows Drive Check

set /p num=Your Option:

if "%num%"=="1" (
    echo.
    echo WELCOME To Windows CPU Finder !!!
    echo -------------------------------------------------
    wmic cpu get deviceid, caption, name, numberofcores, maxclockspeed
    pause
    goto menu
) 

else if "%num%"=="2" (
    echo.
    echo WELCOME To Windows Drive Check !!!
    echo -------------------------------------------------
    wmic diskdrive get status, model, serialNumber, size, mediaType
    wmic /namespace:\\root\wmi path MSStorageDriver_FailurePredictStatus
    wmic diskdrive get model, index, firmwareRevision, status, interfaceType, totalHeads, totalTracks, totalCylinders, totalSectors, partitions

    set /p "driveletter=Your Drive Partition Letter :"
    set "driveletter=%driveletter:~0,1%:"
    
    if not exist %driveletter% (
        echo Invalid drive letter. Please choose again.
        pause
        goto menu
    )
    
    winsat disk -drive %driveletter%
    chkdsk /f %driveletter%
    pause
    goto menu
)

