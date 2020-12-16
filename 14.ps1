# Day 14
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$inputs = Get-Content .\14.txt
# Cleanup the inputs a bit
for ($i = 0; $i -lt $inputs.Count; $i++) {
    $inputs[$i] = $inputs[$i] -replace " ", ""
    $inputs[$i] = $inputs[$i] -replace "\[", ""
    $inputs[$i] = $inputs[$i] -replace "\]", ""
}

# Part 1
$mem = @{}
foreach ($inst in $inputs) {
    $inst = $inst -split "="
    if ($inst[0] -eq "mask") { $mask = $inst[1].PadLeft(64,"0"); continue }
    $inst[0] = $inst[0] -replace "mem", ""
    $num = [Convert]::ToString([int64]($inst[1]),2).PadLeft(64,"0").ToCharArray()       # convert to array of bits
    for ($c = $mask.Length-1; $c -ge 0; $c--) {
        if ($mask[$c] -eq "X") { continue } else { $num[$c] = $mask[$c] }               # set the mask bits
    }
    $mem.($inst[0]) = [convert]::ToInt64($num -join "",2)                               # store
}
$sum = 0
foreach ($k in $mem.Keys) { $sum += $mem.$k }
Write-Output "Part 1: $($sum)"

# Part 2
$mem = @{}
foreach ($inst in $inputs) {
    $inst = $inst -split "="
    if ($inst[0] -eq "mask") { $mask = $inst[1].PadLeft(64,"0"); continue }
    $inst[0] = $inst[0] -replace "mem", ""
    $num = [Convert]::ToString([int64]$inst[0],2).PadLeft(64,"0").ToCharArray()         # convert to array of bits
    for ($c = $mask.Length-1; $c -ge 0; $c--) {                                         # set the required mask bits
        if ($mask[$c] -ne "1") { continue } else { $num[$c] = "1" }
    }
    $bits = @()
    for ($c = 0; $c -lt $mask.Length; $c++) { if ($mask[$c] -eq "X") { $bits += $c } }  # create list of all bits to flip
    $comb = [Math]::Pow(2, $bits.Count)                                                 # number of needed combinations
    for ($x = 0; $x -lt $comb; $x++) {
        $tmp = [convert]::ToString($x,2).PadLeft($bits.Count, "0")                      # create a mask so we know what to change
        for ($c = 0; $c -lt $tmp.Length; $c++) { $num[$bits[$c]] = $tmp[$c] }           # update required bits
        $mem.([convert]::ToInt64($num -join "",2)) = [int64]$inst[1]                    # store in mem
    }
}
$sum = 0
foreach ($k in $mem.Keys) { $sum += $mem.$k }
Write-Output "Part 2: $($sum)"