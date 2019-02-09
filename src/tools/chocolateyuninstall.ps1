$ErrorActionPreference = 'Stop'

$installPath = "$env:ChocolateyToolsLocation\NiftyWindows-0.9.3.1"

if (Test-Path $installPath) {
    Remove-Item $installPath -Recurse
}

$startMenuPrograms = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"

$shortcuts = @(
    "$startMenuPrograms\NiftyWindows.lnk"
    "$startMenuPrograms\Startup\NiftyWindows.lnk"
)

foreach ($shortcut in $shortcuts) {
    if (Test-Path $shortcut) {
        Remove-Item $shortcut
    }
}
