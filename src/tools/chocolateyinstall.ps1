﻿$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$zipLocation = Join-Path $toolsDir 'NiftyWindows-0.9.3.1.zip'

$pp = Get-PackageParameters

$settings = @{
    ToolTipFeedback   = 1
    AutoSuspend       = 1
    FocusFollowsMouse = 0
    Left              = 1
    Middle            = 1
    Right             = 1
    Fourth            = 1
    Fifth             = 1
}

if ($pp.Count) {
    foreach ($key in @($settings.Keys)) {
        if ($pp.ContainsKey($key)) {
            $settings[$key] = if ($pp[$key]) {1} else {0}
        }
        else {
            $settings[$key] = 0
        }
    }
}

$installPath = "$env:ChocolateyToolsLocation\NiftyWindows-0.9.3.1"
Get-ChocolateyUnzip $zipLocation $installPath

$startMenuPrograms = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
$targetPath = "$installPath\NiftyWindows.exe"
$iconPath = "$toolsDir\NiftyWindows.ico"

Install-ChocolateyShortcut `
    -shortcutFilePath "$startMenuPrograms\NiftyWindows.lnk" `
    -targetPath $targetPath `
    -iconLocation $iconPath

Install-ChocolateyShortcut `
    -shortcutFilePath "$startMenuPrograms\Startup\NiftyWindows.lnk" `
    -targetPath $targetPath `
    -iconLocation $iconPath

$configFilePath = "$installPath\NiftyWindows.ini"

"[Main]
AutoSuspend=$($settings['AutoSuspend'])
[WindowHandling]
FocusFollowsMouse=$($settings['FocusFollowsMouse'])
[Visual]
ToolTipFeedback=$($settings['ToolTipFeedback'])
[UpdateCheck]
[MouseHooks]
LeftMouseButton=$($settings['Left'])
MiddleMouseButton=$($settings['Middle'])
RightMouseButton=$($settings['Right'])
FourthMouseButton=$($settings['Fourth'])
FifthMouseButton=$($settings['Fifth'])" |
    Out-File $configFilePath -Force

Install-BinFile "NiftyWindows" $targetPath

Invoke-Expression $targetPath
