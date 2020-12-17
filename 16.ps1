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

# our ticket goes here
$v_tickets += ""


# Part 2
$len = ($v_tickets[0] -split ",").Count
foreach ($f in $fields.Keys) {
    for ($t = 0; $t -lt $len; $t++) {
        $ok = $true
        foreach ($ticket in $v_tickets) {
            $ticket = $ticket -split "," -as [int[]]
            if ( $fields.$f.p1[0] -le $ticket[$t] -and $ticket[$t] -le $fields.$f.p1[1] ) { }
            elseif ($fields.$f.p1[2] -le $ticket[$t] -and $ticket[$t] -le $fields.$f.p1[3]) { } 
            else { $ok = $false; break }
        }
        if ($ok) { $fields.$f.p2 += $t } # Get all valid columns
    }
}

# order them by member count
$ordered = @()
for ($c = 1; $c -lt 20; $c++) {
    foreach ($f in $fields.Keys) { if ($fields.$f.p2.Count -eq $c) { $ordered += $f } }
}

# get the column that's not yet used
$used = @()
for ($i = 0; $i -lt $ordered.Count; $i++) {
    $f = $ordered[$i]
    foreach ($v in $fields.$f.p2) { if ($v -notin $used) { $used += $v; $fields.$f.col = $v; break } }
}

# calculate the result
$keys = $fields.Keys | Where-Object { $_ -like "departure*" }
$res = 1
foreach ($k in $keys) { 
    $res *= ($v_tickets[$v_tickets.Count-1] -split ",")[$fields.$k.col] 
}
Write-Output "Part 1: $($res)"