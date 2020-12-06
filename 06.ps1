# Day 06
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$inputs = Get-Content .\06.txt
$inputs += ""

$group     = @{} # keep track of all answers
$g_count   = 0   # keep track of members in each group
$sum_part1 = 0
$sum_part2 = 0
for ($l = 0; $l -lt $inputs.Length; $l++) {
    if ($inputs[$l] -eq "") {
        # any answered question 
        $sum_part1 += $group.Keys.Count
        # only questions answered by every member of the group
        $group.Keys | ForEach-Object { if ($group.$_ -eq $g_count) { $sum_part2++ } }
        $group = @{}
        $g_count = 0
    } else {
        $inputs[$l].ToCharArray() | ForEach-Object {
            if ($_ -notin $group.Keys) { $group.$_ = 1 } else { $group.$_++ }
        }
        $g_count++
    }
}

Write-Output "Part 1: $($sum_part1)"
Write-Output "Part 2: $($sum_part2)"