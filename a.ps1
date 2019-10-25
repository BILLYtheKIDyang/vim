1+1
26 * 1.15
"Hello" + " World"
Get-Process | head
function Prompt {
   $id = 1
   $historyItem = Get-History -Count 1
   if ($historyItem) {
      $id = $historyItem.Id + 1
   }
   Write-Host -ForegroundColor DarkGray "`n[$(Get-Location)]"
   Write-Host -NoNewLine "PS:$id > "
   $host.UI.RawUI.WindowTitle = "$(Get-Location)"
   "`b"
}
