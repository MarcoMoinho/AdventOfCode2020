# Day 05
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$inputs = Get-Content .\05.txt

function Get-Seat ([string] $bsp) {
    $min = 0; $max = 128
    for ($char = 0; $char -lt 7; $char++) {
        switch ($bsp[$char]) {
            "F" { $max = $max - ($max - $min) / 2 }
            "B" { $min = $max - ($max - $min) / 2 }
        }
    }
    $row = $max - 1
    $min = 0; $max = 8
    for ($char = 7; $char -lt 10; $char++) {
        switch ($bsp[$char]) {
            "L" { $max = $max - ($max - $min) / 2 }
            "R" { $min = $max - ($max - $min) / 2 }
        }
    }
    $col = $max - 1
    return $row * 8 + $col
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