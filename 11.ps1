# Day 11
Set-StrictMode -Version "Latest"
$ErrorActionPreference = "Stop"

$layout = Get-Content .\11.txt
$height = $layout.Length
$width  = $layout[0].Length

# create a matrix
$seats = New-Object 'char[,]' $width, $height

# populate
for ($y = 0; $y -lt $layout.Count; $y++) {
    $str = $layout[$y].ToCharArray()
    for ($x = 0; $x -lt $str.Count; $x++) {
        $seats[$x,$y] = $str[$x]
    }
}

function Test-EmptySeats([ref]$seats, [int]$x, [int]$y) {
    $x_len = $seats.value.GetLength(0); $y_len = $seats.value.GetLength(1)
    for ($yy = -1; $yy -le 1; $yy++) {
        if (($y + $yy -lt 0) -or ($y + $yy -ge $y_len)) { continue }
        for ($xx = -1; $xx -le 1; $xx++) {
            if ($xx -eq 0 -and $yy -eq 0) { continue }
            if (($x + $xx -lt 0) -or ($x + $xx -ge $x_len)) { continue }
            if ($seats.value[($x + $xx),($y + $yy)] -eq "#") { return $false }
        }   
    }
    return $true
}
function Test-OccupiedSeats([ref]$seats, [int]$x, [int]$y) {
    $x_len = $seats.value.GetLength(0); $y_len = $seats.value.GetLength(1)
    $count = 0
    for ($yy = -1; $yy -le 1; $yy++) {
        if (($y + $yy -lt 0) -or ($y + $yy -ge $y_len)) { continue }
        for ($xx = -1; $xx -le 1; $xx++) {
            if ($xx -eq 0 -and $yy -eq 0) { continue }
            if (($x + $xx -lt 0) -or ($x + $xx -ge $x_len)) { continue }
            if ($seats.value[($x + $xx),($y + $yy)] -eq "#") { 
                $count++
                if ($count -ge 4) { return $true }
            }
        }   
    }
    return $false
}

# Calculate Part 1
do {
    $changed = $false
    $new = $seats.Clone()
    for ($y = 0; $y -lt $height; $y++) {
        for ($x = 0; $x -lt $width; $x++) {
            if ($seats[$x,$y] -eq ".") { continue }
            if ($seats[$x,$y] -eq "L") {
                if (Test-EmptySeats ([ref]$seats) $x $y) {
                    $new[$x,$y] = "#"
                    $changed = $true
                }
            }
            if ($seats[$x,$y] -eq "#") {
                if (Test-OccupiedSeats ([ref]$seats) $x $y) {
                    $new[$x,$y] = "L"
                    $changed = $true
                }
            }
        }
    }
    $seats = $new.Clone()
} while ($changed)

$sum = 0
for ($y = 0; $y -lt $height; $y++) {
    for ($x = 0; $x -lt $width; $x++) {
        if ($seats[$x,$y] -eq "#") {$sum++}
    }
}
Write-Output "Part 1: $($sum)"