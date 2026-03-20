## ============================================================
## The Scholarship Strategy - GitHub Pages Deployment Script
## ============================================================
## Run: powershell -ExecutionPolicy Bypass -File "deploy-github-pages.ps1"
##
## This script:
## 1. Copies the hub index.html to the repo root
## 2. Copies all 15 HTML tools into their GitHub Pages paths as index.html
## 3. Injects the nav-inject.js script tag into each tool page
## 4. Verifies the final structure
## ============================================================

$base = "F:\1. Business\Thiink-Media-Graphics\Jobs Nitro\Joaquin Thompson Sr\New Courses\Scholarships\Local Computer Course"
$repo = "$base\Extras\scholarship-strategy-tools"
$source = "$base\Extras\The Scholarship Strategy Github"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  SCHOLARSHIP STRATEGY - GITHUB PAGES SETUP" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# -----------------------------------------------------------
# STEP 1: Copy the hub index.html
# -----------------------------------------------------------
Write-Host "[Step 1] Hub index.html" -ForegroundColor Yellow

# Check repo root first, then Downloads
$hubSource = "$repo\hub-index.html"
if (-not (Test-Path $hubSource)) {
    $hubSource = "$env:USERPROFILE\Downloads\hub-index.html"
}

if (Test-Path $hubSource) {
    Copy-Item $hubSource "$repo\index.html" -Force
    Write-Host "  -> Copied hub-index.html as index.html" -ForegroundColor Green
} elseif (Test-Path "$repo\index.html") {
    Write-Host "  -> Hub index.html already exists" -ForegroundColor Green
} else {
    Write-Host "  -> WARNING: hub-index.html not found. Place it in this folder or Downloads." -ForegroundColor Red
}

# -----------------------------------------------------------
# STEP 2: Copy tool HTML files into GitHub Pages structure
# -----------------------------------------------------------
Write-Host ""
Write-Host "[Step 2] Copying tool HTML files..." -ForegroundColor Yellow

$tools = @(
    @{ src = "Module 1\Lesson 1.1 Scholarship Ecosystem Map Explorer.html"; dst = "module-1\lesson-1-1" },
    @{ src = "Module 1\Lesson 1.2 Myth Vs Fact.html"; dst = "module-1\lesson-1-2" },
    @{ src = "Module 1\Lesson 1.3 Scholarship Flow.html"; dst = "module-1\lesson-1-3" },
    @{ src = "Module 2\Lesson 2.1 Scholarship Source Finder.html"; dst = "module-2\lesson-2-1" },
    @{ src = "Module 2\Lesson 2.2 Scholarship Type Sorter.html"; dst = "module-2\lesson-2-2" },
    @{ src = "Module 2\Lesson 2.3 Scam Detector.html"; dst = "module-2\lesson-2-3" },
    @{ src = "Module 3\Lesson 3.1 Scholarship Creator.html"; dst = "module-3\lesson-3-1-creator" },
    @{ src = "Module 3\Lesson 3.1 Scholarship Search.html"; dst = "module-3\lesson-3-1-search" },
    @{ src = "Module 3\Lesson 3.2 Local Scholarship Hunter.html"; dst = "module-3\lesson-3-2" },
    @{ src = "Module 3\Lesson 3.3 Essay Block Builder.html"; dst = "module-3\lesson-3-3" },
    @{ src = "Module 4\Lesson 4.1A Scholarship Timeline Builder.html"; dst = "module-4\lesson-4-1a" },
    @{ src = "Module 4\Lesson 4.1B College Scholarship Finder.html"; dst = "module-4\lesson-4-1b" },
    @{ src = "Module 4\Lesson 4.2B Aid Risk Detector.html"; dst = "module-4\lesson-4-2b" },
    @{ src = "Module 5\Lesson 5.2 COA Adjustment Scenarios.html"; dst = "module-5\lesson-5-2" },
    @{ src = "Module 6\Lesson 6.1 Appeal Outline Builder.html"; dst = "module-6\lesson-6-1" }
)

$copied = 0
foreach ($tool in $tools) {
    $srcPath = "$source\$($tool.src)"
    $dstDir = "$repo\$($tool.dst)"
    $dstPath = "$dstDir\index.html"

    if (-not (Test-Path $dstDir)) {
        New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
    }

    if (Test-Path $srcPath) {
        Copy-Item $srcPath $dstPath -Force
        $copied++
        Write-Host "  -> $($tool.dst)/index.html" -ForegroundColor Gray
    } else {
        Write-Host "  -> MISSING: $($tool.src)" -ForegroundColor Red
    }
}
Write-Host "  Copied $copied of $($tools.Count) tool files" -ForegroundColor Green

# -----------------------------------------------------------
# STEP 3: Inject nav-inject.js into each tool page
# -----------------------------------------------------------
Write-Host ""
Write-Host "[Step 3] Injecting back-nav script into tool pages..." -ForegroundColor Yellow

$injected = 0
foreach ($tool in $tools) {
    $filePath = "$repo\$($tool.dst)\index.html"
    
    if (Test-Path $filePath) {
        $content = Get-Content $filePath -Raw -Encoding UTF8
        
        if ($content -match "nav-inject\.js") {
            Write-Host "  -> Already injected: $($tool.dst)" -ForegroundColor Gray
            $injected++
            continue
        }

        $depth = ($tool.dst -split '\\').Count
        $relPath = ("../" * $depth) + "nav-inject.js"

        $scriptTag = "`n    <script src=`"$relPath`"></script>"
        $content = $content -replace "</body>", "$scriptTag`n</body>"
        
        Set-Content -Path $filePath -Value $content -Encoding UTF8 -NoNewline
        $injected++
        Write-Host "  -> Injected: $($tool.dst) (ref: $relPath)" -ForegroundColor Gray
    }
}
Write-Host "  Injected nav-inject.js into $injected pages" -ForegroundColor Green

# -----------------------------------------------------------
# STEP 4: Verify final structure
# -----------------------------------------------------------
Write-Host ""
Write-Host "[Step 4] Verifying final structure..." -ForegroundColor Yellow
Write-Host ""

$totalSize = 0

Write-Host "  Root:" -ForegroundColor Cyan
Get-ChildItem $repo -File | ForEach-Object {
    $totalSize += $_.Length
    Write-Host "    $($_.Name) ($([math]::Round($_.Length/1KB, 1)) KB)" -ForegroundColor White
}

$modules = @("module-1", "module-2", "module-3", "module-4", "module-5", "module-6")
foreach ($mod in $modules) {
    $modPath = "$repo\$mod"
    if (Test-Path $modPath) {
        $lessons = Get-ChildItem $modPath -Directory
        Write-Host "  $mod/ ($($lessons.Count) lessons)" -ForegroundColor Cyan
        foreach ($lesson in $lessons) {
            $idx = "$($lesson.FullName)\index.html"
            if (Test-Path $idx) {
                $size = (Get-Item $idx).Length
                $totalSize += $size
                Write-Host "    $($lesson.Name)/index.html ($([math]::Round($size/1KB, 1)) KB)" -ForegroundColor White
            } else {
                Write-Host "    $($lesson.Name)/ (MISSING index.html)" -ForegroundColor Red
            }
        }
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  GITHUB PAGES REPO READY!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Total size: $([math]::Round($totalSize/1KB, 0)) KB" -ForegroundColor White
Write-Host "  Location: $repo" -ForegroundColor White
Write-Host ""
Write-Host "  NEXT STEPS:" -ForegroundColor Yellow
Write-Host "  1. Create repo 'scholarship-strategy-tools' on GitHub" -ForegroundColor White
Write-Host "     (github.com/thiinkmediagraphics)" -ForegroundColor Gray
Write-Host "  2. cd into $repo" -ForegroundColor White
Write-Host "  3. git init" -ForegroundColor White
Write-Host "  4. git add ." -ForegroundColor White
Write-Host "  5. git commit -m 'Initial deploy: 15 interactive tools'" -ForegroundColor White
Write-Host "  6. git remote add origin https://github.com/thiinkmediagraphics/scholarship-strategy-tools.git" -ForegroundColor White
Write-Host "  7. git push -u origin main" -ForegroundColor White
Write-Host "  8. Enable GitHub Pages (Settings > Pages > main branch)" -ForegroundColor White
Write-Host ""
Write-Host "  Live URL: https://thiinkmediagraphics.github.io/scholarship-strategy-tools/" -ForegroundColor Cyan
Write-Host ""
