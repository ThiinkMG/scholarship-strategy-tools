# Claude Code Handoff — The Scholarship Strategy Interactive Tools

## GitHub Pages Deployment Instructions

**Date:** March 20, 2026
**Project:** The Scholarship Strategy — Interactive Tools Hub
**Owner:** Thiink Media Graphics (on behalf of My College Finance)
**GitHub Account:** `thiinkmediagraphics`

---

## Objective

Create a GitHub repository and deploy a GitHub Pages site for **15 interactive HTML scholarship tools** that accompany The Scholarship Strategy online course. The repo is fully built locally and ready to push.

---

## Local Repo Location

```
F:\1. Business\Thiink-Media-Graphics\Jobs Nitro\Joaquin Thompson Sr\New Courses\Scholarships\Local Computer Course\Extras\scholarship-strategy-tools
```

---

## Current State — READY TO DEPLOY

The local folder is a complete, clean repo with all files in place:

### Root Files
| File | Purpose |
|------|---------|
| `index.html` | Hub landing page — search, filter, launch tools |
| `nav-inject.js` | JavaScript injected into every tool page, adds "Back to All Tools" nav bar |
| `README.md` | Full repo readme with badges, screenshots, tool links, support info |

### Assets Folder (`assets/`)
| File | Purpose |
|------|---------|
| `interactive-scholarship-tools-homepage-screenshot.png` | Homepage screenshot referenced by README |
| `hub-index.html` | Backup of the hub page source |
| `Lesson-1.2-Myth-vs-Fact.html` | Backup of Myth vs Fact source |
| `deploy-github-pages.ps1` | PowerShell deployment script (not deployed) |
| `place-myth-vs-fact.ps1` | PowerShell placement script (not deployed) |
| `cleanup.ps1` | PowerShell cleanup script (not deployed) |

### Module Folders (15 interactive tools)
```
module-1/
  lesson-1-1/index.html    — Scholarship Ecosystem Map Explorer
  lesson-1-2/index.html    — Myth vs. Fact (Scholarship ROI)
  lesson-1-3/index.html    — Scholarship Legitimacy Flow

module-2/
  lesson-2-1/index.html    — Scholarship Source Finder
  lesson-2-2/index.html    — Scholarship Type Sorter
  lesson-2-3/index.html    — Scam Detector

module-3/
  lesson-3-1-creator/index.html  — Scholarship Resume Creator
  lesson-3-1-search/index.html   — Scholarship Search
  lesson-3-2/index.html          — Local Scholarship Hunter
  lesson-3-3/index.html          — Essay Block Builder

module-4/
  lesson-4-1a/index.html   — Scholarship Timeline Builder (HS Track)
  lesson-4-1b/index.html   — College Scholarship Finder (College Track)
  lesson-4-2b/index.html   — Aid Risk Detector (College Track)

module-5/
  lesson-5-2/index.html    — COA Adjustment Scenarios

module-6/
  lesson-6-1/index.html    — Appeal Outline Builder
```

Every tool page already has the `nav-inject.js` script tag injected before `</body>`.

---

## Deployment Steps

### Step 1: Create the GitHub Repository

1. Go to [github.com/new](https://github.com/new)
2. **Owner:** `thiinkmediagraphics`
3. **Repository name:** `scholarship-strategy-tools`
4. **Description:** `Free interactive scholarship tools from The Scholarship Strategy course by My College Finance`
5. **Visibility:** Public
6. **Do NOT** initialize with README, .gitignore, or license (the repo already has a README)
7. Click **Create repository**

### Step 2: Initialize and Push

Open terminal/PowerShell in the local repo folder and run:

```bash
cd "F:\1. Business\Thiink-Media-Graphics\Jobs Nitro\Joaquin Thompson Sr\New Courses\Scholarships\Local Computer Course\Extras\scholarship-strategy-tools"

git init
git add .
git commit -m "Initial deploy: 15 interactive scholarship tools with hub page"
git branch -M main
git remote add origin https://github.com/thiinkmediagraphics/scholarship-strategy-tools.git
git push -u origin main
```

### Step 3: Enable GitHub Pages

1. Go to: `https://github.com/thiinkmediagraphics/scholarship-strategy-tools/settings/pages`
2. Under **Source**, select: **Deploy from a branch**
3. **Branch:** `main`
4. **Folder:** `/ (root)`
5. Click **Save**
6. Wait 1-2 minutes for initial deployment

### Step 4: Verify Live Site

The site should be live at:
```
https://thiinkmediagraphics.github.io/scholarship-strategy-tools/
```

Verify:
- [ ] Hub page loads with all 15 tool cards
- [ ] Search and module filter buttons work
- [ ] Dark mode toggle works
- [ ] Clicking "Launch Tool" navigates to the tool page
- [ ] "Back to All Tools" nav bar appears on each tool page
- [ ] Back-nav links return to the hub
- [ ] At least 3-4 tools function correctly (map, quiz, forms)
- [ ] README screenshot displays on the GitHub repo page

---

## Optional: .gitignore

You may want to add a `.gitignore` to exclude the PowerShell scripts in assets from the deploy. This is optional since GitHub Pages serves everything in the repo anyway and the scripts don't harm anything.

```
# Optional .gitignore
assets/*.ps1
```

---

## Optional: Custom Domain

If My College Finance wants a custom subdomain later (e.g., `tools.mycollegefinance.com`):

1. In GitHub repo Settings > Pages > Custom domain, enter: `tools.mycollegefinance.com`
2. Add a CNAME record in the DNS provider pointing `tools` to `thiinkmediagraphics.github.io`
3. GitHub will auto-provision HTTPS via Let's Encrypt

---

## URL Reference

| Resource | URL |
|----------|-----|
| **Hub (live)** | `https://thiinkmediagraphics.github.io/scholarship-strategy-tools/` |
| **GitHub Repo** | `https://github.com/thiinkmediagraphics/scholarship-strategy-tools` |
| **Example Tool URL** | `https://thiinkmediagraphics.github.io/scholarship-strategy-tools/module-1/lesson-1-1/` |
| **iframe Embed** | `<iframe src="https://thiinkmediagraphics.github.io/scholarship-strategy-tools/module-1/lesson-1-1/" width="100%" height="800" frameborder="0"></iframe>` |

---

## Technical Notes

- **Framework:** Pure HTML/CSS/JS — no build step, no dependencies, no Node.js
- **Branding:** MCF brand system (brand blue #012699, brand green #26e011, brand amber #fdc003)
- **Logo:** Loaded from Wix CDN: `https://static.wixstatic.com/media/c24a60_2b6231b666214539ae22ebd2dffe7a09~mv2.png`
- **Dark mode:** All tools and the hub share `localStorage.getItem('mcf-theme')` for consistent dark mode across pages
- **nav-inject.js:** Self-executing IIFE that injects a branded back-nav bar at `document.body.firstChild`. Automatically calculates relative path depth to find itself. No modification needed when adding new tools.
- **Adding new tools:** Create `module-X/lesson-X-X/index.html`, add `<script src="../../nav-inject.js"></script>` before `</body>`, and add the tool entry to the `tools` array in `index.html`.

---

## Repo Branding

- **MCF Brand Blue:** `#012699`
- **MCF Brand Green:** `#26e011`
- **MCF Brand Amber:** `#fdc003`
- **MCF Brand Black:** `#000516`
- **Tagline:** EDUCATE • MOTIVATE • ELEVATE
- **Copyright:** © 2025 My College Finance. All rights reserved.
- **Logo URL:** `https://static.wixstatic.com/media/c24a60_2b6231b666214539ae22ebd2dffe7a09~mv2.png`

---

## Contact

- **Client:** Joaquin Thompson Sr. / My College Finance
- **Developer:** Thiink Media Graphics (`team@thiinkmediagraphics.com`)
- **Website:** [mycollegefinance.com](https://www.mycollegefinance.com/)
- **Social:** [linktr.ee/mycollegefinance](https://linktr.ee/mycollegefinance)
