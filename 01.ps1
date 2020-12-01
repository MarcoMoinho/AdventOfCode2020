# Day 01
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$target = 2020

$inputs = @() 
Get-Content .\01.txt | ForEach-Object { $inputs += [int]$_ }

function Get-Part1 {
    param (
        [Parameter(mandatory)] [object] $inputs,
        [Parameter(mandatory)] [int]    $target
    )
    
    for ($a = 0; $a -lt $inputs.Count; $a++) {
        for ($b = 0; $b -lt $inputs.Count; $b++) {
            if ($a -eq $b) { continue }
            if ($inputs[$a] + $inputs[$b] -eq $target) { return $inputs[$a] * $inputs[$b] }
        }
    }
}

function Get-Part2 {
    param (
        [Parameter(mandatory)] [object] $inputs,
        [Parameter(mandatory)] [int]    $target
    )
    
    for ($a = 0; $a -lt $inputs.Count; $a++) {
        for ($b = 0; $b -lt $inputs.Count; $b++) {
            if ($a -eq $b) { continue }
            for ($c = 0; $c -lt $inputs.Count; $c++) {
                if ($b -eq $c) { continue }
                if ($inputs[$a] + $inputs[$b] + $inputs[$c] -eq $target) { return $inputs[$a] * $inputs[$b] * $inputs[$c] }
            }
        }
    }

}


# Part 1
Get-Part1 -inputs $inputs -target $target

# Part 2
Get-Part2 -inputs $inputs -target $target
