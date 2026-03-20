## ============================================================
## CLEANUP & PLACE FILES - One-shot script
## ============================================================
## Run: powershell -ExecutionPolicy Bypass -File "cleanup.ps1"
## ============================================================

$base = "F:\1. Business\Thiink-Media-Graphics\Jobs Nitro\Joaquin Thompson Sr\New Courses\Scholarships\Local Computer Course"
$repo = "$base\Extras\scholarship-strategy-tools"
$mythFile = "$repo\Lesson-1.2-Myth-vs-Fact.html"
$hubFile = "$repo\hub-index.html"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  CLEANUP & PLACE FILES" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# -----------------------------------------------------------
# 1. Place Lesson 1.2 Myth vs Fact in all 3 locations
# -----------------------------------------------------------
Write-Host "[1] Placing Lesson 1.2 Myth vs Fact..." -ForegroundColor Yellow

if (Test-Path $mythFile) {
    # A) Original course folder
    Copy-Item $mythFile "$base\Module 1\Lesson 1.2\Lesson 1.2 Myth Vs Fact - HTML.md" -Force
    Write-Host "  -> Module 1/Lesson 1.2/ (original course folder)" -ForegroundColor Green

    # B) Github flat copy folder
    Copy-Item $mythFile "$base\Extras\The Scholarship Strategy Github\Module 1\Lesson 1.2 Myth Vs Fact.html" -Force
    Write-Host "  -> The Scholarship Strategy Github/Module 1/" -ForegroundColor Green

    # C) GitHub Pages repo
    $pagesDir = "$repo\module-1\lesson-1-2"
    if (-not (Test-Path $pagesDir)) { New-Item -ItemType Directory -Path $pagesDir -Force | Out-Null }
    Copy-Item $mythFile "$pagesDir\index.html" -Force
    Write-Host "  -> module-1/lesson-1-2/index.html (GitHub Pages)" -ForegroundColor Green
} else {
    Write-Host "  -> ERROR: Lesson-1.2-Myth-vs-Fact.html not found in repo root" -ForegroundColor Red
}

# -----------------------------------------------------------
# 2. Move hub-index.html to assets (keep index.html as the live copy)
# -----------------------------------------------------------
Write-Host ""
Write-Host "[2] Moving extra root files to assets..." -ForegroundColor Yellow

if (Test-Path $hubFile) {
    # If index.html doesn't exist yet, create it from hub-index.html first
    if (-not (Test-Path "$repo\index.html")) {
        Copy-Item $hubFile "$repo\index.html" -Force
        Write-Host "  -> Created index.html from hub-index.html" -ForegroundColor Green
    }
    # Move hub-index.html to assets as backup
    Move-Item $hubFile "$repo\assets\hub-index.html" -Force
    Write-Host "  -> Moved hub-index.html to assets/" -ForegroundColor Green
}

# Move the Myth vs Fact source file to assets too (copies are in place now)
if (Test-Path $mythFile) {
    Move-Item $mythFile "$repo\assets\Lesson-1.2-Myth-vs-Fact.html" -Force
    Write-Host "  -> Moved Lesson-1.2-Myth-vs-Fact.html to assets/" -ForegroundColor Green
}

# Move PowerShell scripts to assets (not needed in deployed repo)
if (Test-Path "$repo\place-myth-vs-fact.ps1") {
    Move-Item "$repo\place-myth-vs-fact.ps1" "$repo\assets\place-myth-vs-fact.ps1" -Force
    Write-Host "  -> Moved place-myth-vs-fact.ps1 to assets/" -ForegroundColor Green
}
if (Test-Path "$repo\deploy-github-pages.ps1") {
    Move-Item "$repo\deploy-github-pages.ps1" "$repo\assets\deploy-github-pages.ps1" -Force
    Write-Host "  -> Moved deploy-github-pages.ps1 to assets/" -ForegroundColor Green
}

# Move this script to assets too
$thisScript = "$repo\cleanup.ps1"
# (will move after execution completes)

# -----------------------------------------------------------
# 3. Verify clean root
# -----------------------------------------------------------
Write-Host ""
Write-Host "[3] Final repo root contents:" -ForegroundColor Yellow

Get-ChildItem $repo -File | ForEach-Object {
    Write-Host "  $($_.Name) ($([math]::Round($_.Length/1KB, 1)) KB)" -ForegroundColor White
}
Get-ChildItem $repo -Directory | ForEach-Object {
    Write-Host "  $($_.Name)/" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Assets folder:" -ForegroundColor Yellow
Get-ChildItem "$repo\assets" -File -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "  $($_.Name) ($([math]::Round($_.Length/1KB, 1)) KB)" -ForegroundColor Gray
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  DONE! Root is clean, files are placed." -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "  TIP: Move cleanup.ps1 to assets/ manually:" -ForegroundColor Gray
Write-Host "  Move-Item cleanup.ps1 assets\cleanup.ps1" -ForegroundColor Gray
Write-Host ""
