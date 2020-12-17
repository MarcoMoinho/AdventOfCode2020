# Day 16
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$fields  = @{}
$tickets = Get-Content .\16.txt
$v_tickets = @()
Get-Content .\16_f.txt | ForEach-Object {
    $tmp = $_ -split ":"
    $field = $tmp[0]
    $fields.$field = @{ p1 = @(); p2 = @() }
    $tmp = $tmp[1] -replace " ", ""
    $tmp = $tmp -split "or"
    $tmp[0] -split "-" | ForEach-Object { $fields.$field.p1 += [int]$_ }
    $tmp[1] -split "-" | ForEach-Object { $fields.$field.p1 += [int]$_ }
}

# Part 1
$nv = 0
foreach ($ticket in $tickets) {
    $ticket = $ticket -split "," -as [int[]]
    $v_t = $true
    for ($t = 0; $t -lt $ticket.Count; $t++) {
        $v = $false
        foreach ($f in $fields.Keys) {
            if ($fields.$f.p1[0] -le $ticket[$t] -and $ticket[$t] -le $fields.$f.p1[1]) { $v = $true; break }
            if ($fields.$f.p1[2] -le $ticket[$t] -and $ticket[$t] -le $fields.$f.p1[3]) { $v = $true; break }
        }
        if (-not $v) { $nv += $ticket[$t]; $v_t = $false }
    }
    if ($v_t) { $v_tickets += $ticket -join "," } # For P2
}
Write-Output "Part 1: $($nv)"