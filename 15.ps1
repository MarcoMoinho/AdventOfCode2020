# Day 15
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$list = @(0,3,6)
$blist = @(0,3) # same but 1 step behind

$i = $list.Count - 2
do {
    $i++
    if ($list[$i] -notin $blist) { $blist += $list[$i]; $list += 0; continue } # New number
    $s = [array]::LastIndexOf($blist,$list[$i]) # Old number
    $list += $i - $s
    $blist += $list[$i]
} while ($i -lt 2020)

Write-Output "Part 1: $($list[2020-1])"