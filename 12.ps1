# Day 12
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$inputs = Get-Content .\12.txt

function Get-NewDir ([string]$c_dir, [int]$r) {
    $dirs = @('N', 'E', 'S', 'W')
    for ($indx = 0; $indx -le 3; $indx++) { if ($dirs[$indx] -eq $c_dir) { break } }
    if ($r -lt 0) {
        if ($indx + $r -lt 0) { return $dirs[4 + ($indx + $r)] } else { return $dirs[$indx + $r] }
    } else {
        if ($indx + $r -gt 3) { return $dirs[$indx  + $r - 4] }  else { return $dirs[$indx + $r] }
    }
}

function Get-Rotation ([int]$x, [int]$y, [int]$r, [string]$dir) {
    $old_x = $x; $old_y = $y
    for ($i = 0; $i -lt $r; $i++) {
        switch ($dir) {
            "R" { $new_x = $old_y * - 1; $new_y = $old_x }
            "L" { $new_x = $old_y; $new_y = $old_x * - 1 }
        }
        $old_x = $new_x; $old_y = $new_y
    }
    return @($new_x, $new_y)
}

# Part 1
$x = 0; $y = 0
$c_dir = "E"
foreach ($dir in $inputs) {
    $d = $dir[0]
    [int]$val = $dir.Substring(1,$dir.Length-1)
    
    switch ($d) {
        "N" { $y = $y - $val }
        "S" { $y = $y + $val }
        "E" { $x = $x + $val }
        "W" { $x = $x - $val }
        "L" { $c_dir = Get-NewDir $c_dir ($val / 90 * -1) }
        "R" { $c_dir = Get-NewDir $c_dir ($val / 90) }
        "F" {
            switch ($c_dir) {
                "N" { $y = $y - $val }
                "S" { $y = $y + $val }
                "E" { $x = $x + $val }
                "W" { $x = $x - $val }
            }
        }
    }
}
Write-Output ("Part 1: {0}" -f ([math]::Abs($x) + [math]::Abs($y)))

# Part 2
$x = 0; $y = 0
$w_x = 10; $w_y = -1
$c_dir = "E"
foreach ($dir in $inputs) {
    $d = $dir[0]
    [int]$val = $dir.Substring(1,$dir.Length-1)
    switch ($d) {
        "N" { $w_y = $w_y - $val }
        "S" { $w_y = $w_y + $val }
        "E" { $w_x = $w_x + $val }
        "W" { $w_x = $w_x - $val }
        "L" { $wayp = Get-Rotation $w_x $w_y ($val / 90) "L"; $w_x = $wayp[0]; $w_y = $wayp[1] }
        "R" { $wayp = Get-Rotation $w_x $w_y ($val / 90) "R"; $w_x = $wayp[0]; $w_y = $wayp[1] }
        "F" {
            $x = $x + $w_x * $val
            $y = $y + $w_y * $val
        }
    }

}
Write-Output ("Part 2: {0}" -f ([math]::Abs($x) + [math]::Abs($y)))