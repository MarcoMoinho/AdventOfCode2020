# Day 08
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$inputs = Get-Content .\08.txt

function Test-Program ([object] $code) {
    $acc = 0
    $pointer = 0
    do {
        if ($code[$pointer] -eq "") { break } # second loop
        $tmp = $code[$pointer].Split(" ")     # split
        $opc = $tmp[0]                        # get the instruction
        $val = [int]$tmp[1]                   # get the value
        $code[$pointer] = ""                  # clear
        
        switch ($opc) {
            "nop" { }
            "acc" { $acc += $val }
            "jmp" { $pointer += $val }
        }
        if ($opc -ne "jmp") { $pointer++ }
    } while ($pointer -lt $code.Length)

    return @{
        "loop" = ($pointer -lt $code.Length)
        "acc"  = $acc
    }
}

# Part 1
$new = @()
$inputs | ForEach-Object { $new += $_ }
$p1 = Test-Program $new
Write-Output "Part 1: $($p1.acc), loopep?: $($p1.loop)"

# Part 2
# Just brute force it :)
for ($i = 0; $i -lt $inputs.Count; $i++) {
    $opc = $inputs[$i].Substring(0,3)
    if ($opc -notin @("jmp", "nop")) { continue }
    
    $new = @()
    $inputs | ForEach-Object { $new += $_ }
    if ($opc -eq "jmp") { $new[$i] = $new[$i] -replace "jmp", "nop" }
    if ($opc -eq "nop") { $new[$i] = $new[$i] -replace "nop", "jmp" }
    
    $p2 = Test-Program $new
    if (-not $p2.loop) { break }
}
Write-Output "Part 1: $($p2.acc), looped?: $($p2.loop)"