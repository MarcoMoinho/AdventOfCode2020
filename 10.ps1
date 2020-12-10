# Day 10
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$inputs = @() 
[int]$device = 0
Get-Content .\10.txt | ForEach-Object { 
    $inputs += [int]$_
    if ([int]$_ -gt $device) { $device = [int]$_ } 
}

# Part 1
$jolt_diff = @(0,0,0,0)
$jolts = 0
do {
    for ($j = 1; $j -le 3; $j++) {
        if (($jolts + $j) -in $inputs) {
            $jolts += $j
            $jolt_diff[$j] += 1
            break
        }
    }
} while ($jolts -lt $device)
$jolt_diff[3] += 1 # last connection to device
Write-Output "Part 1: $($jolt_diff[1] * $jolt_diff[3])"