# Day 02
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$inputs = Get-Content .\02.txt

$count_p1 = 0
$count_p2 = 0

foreach ($item in $inputs) {

    # Parse the object
    $tmp  = $item -split " "
    $char = $tmp[1].Trim() -replace ":", ""
    $pass = $tmp[2].Trim()
    $tmp  = $tmp[0] -split "-"
    $min  = [int]$tmp[0]
    $max  = [int]$tmp[1]

    # Part 1
    $char_count = $pass.ToCharArray() | Where-Object { $_ -eq $char } | Measure-Object | Select-Object -ExpandProperty Count
    if ($char_count -ge $min -and $char_count -le $max) { $count_p1++ }

    # Part 2
    if ($pass[$min-1] -eq $char -xor $pass[$max-1] -eq $char) { $count_p2++ }
}

Write-Output "Part 1: $($count_p1)"
Write-Output "Part 2: $($count_p2)"