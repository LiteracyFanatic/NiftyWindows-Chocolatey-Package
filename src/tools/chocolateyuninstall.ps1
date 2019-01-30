$ErrorActionPreference = 'Stop'

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
