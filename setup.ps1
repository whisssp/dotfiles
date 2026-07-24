winget install wez.wezterm
winget install --id=DEVCOM.JetBrainsMonoNerdFont

New-Item -ItemType SymbolicLink -Force `
  -Path "$env:USERPROFILE\.wezterm.lua" `
  -Target "$env:USERPROFILE\dotfiles\home\.config\wezterm\wezterm.lua"

Write-Host "Done. Restart WezTerm to pick up the config."
