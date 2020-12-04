# Day 04
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$fields = @("byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid")
$inputs = Get-Content .\04.txt

function Test-ValidityP1 ([string] $text, [object] $fields) {
    foreach ($field in $fields) {
        if ($text -notlike "*$($field)*") { return $false }
    }
    return $true
}

function Test-ValidityP2 ([string] $text) {

    $fields = $text.Trim() -split " "
    $hcl_pattern = "#" + ("[0-9,a-f]" * 6)
    $ecl_vals    = @("amb", "blu", "brn", "gry", "grn", "hzl", "oth")

    foreach ($field in $fields) {
        $data = $field -split ":"
        $val = $data[1]
        switch ($data[0]) {
            "byr" { if ($val -lt 1920 -or $val -gt 2002) { return $false } }
            "iyr" { if ($val -lt 2010 -or $val -gt 2020) { return $false } }
            "eyr" { if ($val -lt 2020 -or $val -gt 2030) { return $false } }
            "hgt" { switch -wildcard ($val) {
                    "*cm" { $val = $val -replace "cm", ""; if ($val -lt 150 -or $val -gt 193) { return $false } }
                    "*in" { $val = $val -replace "in", ""; if ($val -lt 59 -or $val -gt 76)   { return $false } }
                    Default { return $false } } }
            "hcl" { if ($val -notlike $hcl_pattern) { return $false } }
            "ecl" { if ($val -notin $ecl_vals) { return $false } } 
            "pid" { if ($val -notlike ("[0-9]" * 9)) { return $false } }
            "cid" { }
        }
    }
    return $true
}


$valid_part1 = 0
$valid_part2 = 0
$text = @()
for ($i = 0; $i -lt $inputs.Length; $i++) {
    $text += $inputs[$i]
    if ($inputs[$i] -eq "" -or $i -eq ($inputs.Length -1)) {
        if (Test-ValidityP1 -text ($text -join " ") -fields $fields) {
            $valid_part1 ++ 
            if (Test-ValidityP2 -text ($text -join " ")) { $valid_part2 ++ }
        }
        $text = @()
    }
}

Write-Output "Part 1: $($valid_part1)"
Write-Output "Part 2: $($valid_part2)"