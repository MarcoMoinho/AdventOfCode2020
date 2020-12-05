# Day 05
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$inputs = Get-Content .\05.txt

function Get-Seat ([string] $bsp) {
    $row = $bsp.Substring(0,7) -replace "F", "0" -replace "B", "1"
    $col = $bsp.Substring(7,3) -replace "L", "0" -replace "R", "1"
    return ([convert]::ToInt32($row, 2) * 8) + [convert]::ToInt32($col, 2)
}

$part_1 = 0
$part_2 = 0
$first_seat = 1000
$last_seat  = 0
$seats = @()
foreach ($bsp in $inputs) {
    $tmp = Get-Seat $bsp
    if ($tmp -gt $part_1)     { $part_1 = $tmp }
    if ($tmp -lt $first_seat) { $first_seat = $tmp }
    if ($tmp -gt $last_seat)  { $last_seat  = $tmp }
    $seats += $tmp
}

for ($s = $first_seat + 1; $s -lt $last_seat; $s++) {
    if ($s -notin $seats -and ($s-1) -in $seats -and ($s+1) -in $seats) { $part_2 = $s }
}

Write-Output "Part 1: $($part_1)"
Write-Output "Part 2: $($part_2)"