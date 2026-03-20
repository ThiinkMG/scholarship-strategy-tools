## Place Lesson 1.2 Myth vs Fact HTML in all locations
## Run: powershell -ExecutionPolicy Bypass -File "place-myth-vs-fact.ps1"

$base = "F:\1. Business\Thiink-Media-Graphics\Jobs Nitro\Joaquin Thompson Sr\New Courses\Scholarships\Local Computer Course"
$repoRoot = "$base\Extras\scholarship-strategy-tools"

# Check current folder first, then Downloads
$src = "$repoRoot\Lesson-1.2-Myth-vs-Fact.html"
if (-not (Test-Path $src)) {
    $src = "$env:USERPROFILE\Downloads\Lesson-1.2-Myth-vs-Fact.html"
}
if (-not (Test-Path $src)) {
    Write-Host "ERROR: Cannot find 'Lesson-1.2-Myth-vs-Fact.html' in repo root or Downloads" -ForegroundColor Red
    exit
}

Write-Host "Found source: $src" -ForegroundColor Gray
Write-Host ""

# 1. Original Module 1 Lesson folder (replace the empty .md)
Copy-Item $src "$base\Module 1\Lesson 1.2\Lesson 1.2 Myth Vs Fact - HTML.md" -Force
Write-Host "  Copied to Module 1/Lesson 1.2/ (original)" -ForegroundColor Green

# 2. The Scholarship Strategy Github flat copy folder
Copy-Item $src "$base\Extras\The Scholarship Strategy Github\Module 1\Lesson 1.2 Myth Vs Fact.html" -Force
Write-Host "  Copied to Github flat copy (Module 1)" -ForegroundColor Green

# 3. GitHub Pages repo structure
$pagesDir = "$repoRoot\module-1\lesson-1-2"
if (-not (Test-Path $pagesDir)) { New-Item -ItemType Directory -Path $pagesDir -Force | Out-Null }
Copy-Item $src "$pagesDir\index.html" -Force
Write-Host "  Copied to GitHub Pages (module-1/lesson-1-2/index.html)" -ForegroundColor Green

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Lesson 1.2 Myth vs Fact - PLACED IN ALL 3 LOCATIONS!" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
