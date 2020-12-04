# Day 03
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$inputs = @() 
Get-Content .\03.txt | ForEach-Object { $inputs += $_ }
$width = $inputs[0].Length

function Get-Trees ([object] $inputs,[int] $right, [int] $down) {
    $trees = 0; $x = 0; $y = 0
    do {
        if ($inputs[$y][$x] -eq "#") { $trees ++ }
        $x = $x + $right
        if ($x -ge $width) { $x = 0 + ($x - $width) }
        $y = $y + $down
    } while ($y -lt $inputs.Length)
    
    return $trees
}

# Part 1
$p1 = Get-Trees -inputs $inputs -right 3 -down 1
Write-Output "Part 1: $($p1)"

# Part 2
$p2 = 1
for ($i = 1; $i -le 7; $i+=2) {
    $p2 = $p2 * (Get-Trees -inputs $inputs -right $i -down 1)
}
$p2 = $p2 * (Get-Trees -inputs $inputs -right 1 -down 2)
Write-Output "Part 2: $($p2)"