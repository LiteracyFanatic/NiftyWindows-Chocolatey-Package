$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'NiftyWindows-0.9.3.1.zip'

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

Get-ChocolateyUnzip $fileLocation "$toolsDir\NiftyWindows-0.9.3.1"

$startMenuPrograms = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
$targetPath = "$toolsDir\NiftyWindows-0.9.3.1\NiftyWindows.exe"
$iconPath = "$toolsDir\NiftyWindows.ico"

Install-ChocolateyShortcut `
    -shortcutFilePath "$startMenuPrograms\NiftyWindows.lnk" `
    -targetPath $targetPath `
    -iconLocation $iconPath

Install-ChocolateyShortcut `
    -shortcutFilePath "$startMenuPrograms\Startup\NiftyWindows.lnk" `
    -targetPath $targetPath `
    -iconLocation $iconPath

"[Main]
AutoSuspend=$($settings['AutoSuspend'])
[WindowHandling]
FocusFollowsMouse=$($settings['FocusFollowsMouse'])
[Visual]
ToolTipFeedback=$($settings['ToolTipFeedback'])
[UpdateCheck]
LastUpdateCheck=01
[MouseHooks]
LeftMouseButton=$($settings['Left'])
MiddleMouseButton=$($settings['Middle'])
RightMouseButton=$($settings['Right'])
FourthMouseButton=$($settings['Fourth'])
FifthMouseButton=$($settings['Fifth'])" |
    Out-File (Join-Path $toolsDir "NiftyWindows-0.9.3.1\NiftyWindows.ini")

Invoke-Expression $targetPath
