# Day 07
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$bags = @{}
$inputs = Get-Content .\07.txt
$inputs = $inputs -replace " bags", ""      # clean the input a bit
$inputs = $inputs -replace " bag", ""
$inputs = $inputs -replace "\.", ""
$inputs = $inputs -replace " contain ", "|"

# Parse the inputs
for ($line = 0; $line -lt $inputs.Length; $line++) {
    $tmp = $inputs[$line] -split "\|"                   # split bag color and bag contents
    $main_bag = $tmp[0]
    $bags.$main_bag = @{}                               # create the main bag object
    if ($tmp[1] -like "no other*") { continue }         # no bags inside
    $inside_bags = $tmp[1] -split ","                   # split all "inner" bags
    for ($i = 0; $i -lt $inside_bags.Count; $i++) {
        $val = $inside_bags[$i].Trim()
        $index = $val.IndexOf(" ")                      # split bag count and bag name
        $bag_count = $val.Substring(0,$index)
        $bag_name  = $val.Substring($index+1, $val.Length - $index - 1)
        $bags.$main_bag.$bag_name = $bag_count          # add to main bag object
    }
}

function Test-CanCarryBag ([string] $bag_color, [object] $bags, [string] $current_bag = "") {
    $bag_list = $bags.$current_bag.Keys
    if ($bag_list.Count -eq 0)    { return $false }
    if ($bag_color -in $bag_list) { return $true }
    foreach ($bag in $bag_list) { # If not in the list we search one level deeper
        if ((Test-CanCarryBag -bag_color $bag_color -bags $bags -current_bag $bag)) { return $true }
    }
    return $false
}

function Get-BagCount ([object] $bags, [string] $current_bag = "") {
    $sum = 0
    $bag_list = $bags.$current_bag.Keys
    if ($bag_list.Count -eq 0) { return 1 }
    foreach ($bag in $bag_list) { # Get the remaining bags
        $sum = $sum + [int]$bags.$current_bag.$bag * (Get-BagCount -bags $bags -current_bag $bag)
    }
    return $sum + 1 # include itself
}

$part_1 = 0
foreach ($bag in $bags.Keys) {
    if ((Test-CanCarryBag -bag_color "shiny gold" -bags $bags -current_bag $bag)) { $part_1 ++ }
}

$part_2 = Get-BagCount -bags $bags -current_bag "shiny gold"
$part_2 = $part_2 - 1 # do not include itself

Write-Output "Part 1: $($part_1)"
Write-Output "Part 2: $($part_2)"