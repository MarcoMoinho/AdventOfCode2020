# Day 09
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$inputs = @() 
Get-Content .\09.txt | ForEach-Object { $inputs += [Int64]$_ }
$pre = 25

# Part 1
for ($num = $pre; $num -lt $inputs.Length; $num++) {
    # Get the previous numbers $pre numbers
    $array = @()
    for ($index = $num-$pre; $index -lt $num; $index++) { $array+= $inputs[$index] }
    # Search
    $found = $false
    for ($numA = 0; $numA -lt $array.Count; $numA++) {
        for ($numB = 0; $numB -lt $array.Count; $numB++) {
            if ($numA -eq $numB) { continue }
            if ($array[$numA] + $array[$numB] -eq $inputs[$num]) { $found = $true; break }
        }
        if ($found) { break }
    }
    if (-not $found) { $p1 = $inputs[$num]; break }
}
Write-Output "Part 1: $($p1)"

# Part 2
$p2 = 0
for ($num = 0; $num -lt $inputs.Length; $num++) {
    $sum = 0; $min = 0; $max = 0
    # Search indefinitely starting from $num
    for ($numB = $num; $numB -lt $inputs.Length; $numB++) {
        if ($min -eq 0) { $min = $inputs[$numB] }
        if ($inputs[$numB] -gt $max) { $max = $inputs[$numB] }
        if ($inputs[$numB] -lt $min) { $min = $inputs[$numB] }
        $sum += $inputs[$numB]
        if ($sum -eq $p1) { $p2 = $min + $max; break }
        if ($sum -gt $p1) { break }
    }
    if ($p2 -gt 0) { break }
}
Write-Output "Part 2: $($p2)"