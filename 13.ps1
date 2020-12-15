# Day 13
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$t_stamp = 939
$buses   = "7,13,x,x,59,x,31,19" -split ","
$IDs     = @()
$IXs     = @()
for ($i = 0; $i -lt $buses.Count; $i++) { if ($buses[$i] -ne "x") { $IDs += [int]$buses[$i]; $IXs += $i } }

# Part 1
$c_time = $t_stamp
$result = 0
do {
    $c_time ++
    foreach ($ID in $IDs) {
        if ($c_time % $ID -eq 0) { $result = $ID * ($c_time - $t_stamp); break }
    }
} while ($result -eq 0)
Write-Output "Part 1: $($result)"

# Part 2
$t      = 0 # timestamp
$c_bus  = 0 # current bus
$mult   = 1 # current multiplier
$last_v = 0 # last value where it matched
$count  = 0 # keep track of number of matches, we need 2 to set a proper multiplier
do {
    $t += $mult
    $skip = $false
    for ($b = 0; $b -le $c_bus; $b++) {
        if (($t+$IXs[$b]) % $IDs[$b] -ne 0) { $skip = $true; break } # verify all buses match
    }
    if ($skip) { continue }
    $count++
    if ($count -eq 1) {
        $last_v = $t
        if ($c_bus -eq $IDs.Count - 1) { break } else { continue }
    }
    $count = 0
    $c_bus ++               # search next bus
    $mult = $t - $last_v    # modify the multiplier
} while ($c_bus -lt $IDs.Count)
Write-Output "Part 1: $($t)"