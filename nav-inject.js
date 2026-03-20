/**
 * MCF Nav Inject - Back to All Tools Navigation Bar
 * The Scholarship Strategy - Interactive Tools Hub
 * 
 * Include this script in any tool page to add a persistent
 * "Back to All Tools" navigation bar at the top.
 * 
 * Usage: Add before closing </body> tag:
 * <script src="../../nav-inject.js"></script>
 * (adjust ../ depth based on folder nesting)
 */

(function () {
    'use strict';

    // Determine the base path to the hub (root of the GitHub Pages site)
    const scriptTags = document.querySelectorAll('script[src*="nav-inject"]');
    let basePath = './';
    if (scriptTags.length > 0) {
        const src = scriptTags[scriptTags.length - 1].getAttribute('src');
        basePath = src.replace('nav-inject.js', '');
    }

    // Create the nav bar element
    const navBar = document.createElement('div');
    navBar.id = 'mcf-tools-nav-bar';
    navBar.innerHTML = `
        <a href="${basePath}" class="mcf-nav-back-link" title="Back to All Interactive Tools">
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M10 12L6 8L10 4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <span class="mcf-nav-back-text">All Interactive Tools</span>
        </a>
        <div class="mcf-nav-brand-mini">
            <img src="https://static.wixstatic.com/media/c24a60_2b6231b666214539ae22ebd2dffe7a09~mv2.png" alt="MCF" class="mcf-nav-logo-mini">
            <span class="mcf-nav-course-label">The Scholarship Strategy</span>
        </div>
    `;

    // Create styles
    const style = document.createElement('style');
    style.textContent = `
        #mcf-tools-nav-bar {
            position: sticky;
            top: 0;
            z-index: 9999;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.45rem 1rem;
            background: linear-gradient(135deg, #012699 0%, #0139cc 100%);
            color: #ffffff;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            font-size: 0.78rem;
            box-shadow: 0 2px 12px rgba(1, 38, 153, 0.25);
            border-bottom: 2px solid rgba(253, 192, 3, 0.4);
        }

        body.dark-mode #mcf-tools-nav-bar {
            background: linear-gradient(135deg, #000516 0%, #012699 100%);
            border-bottom-color: rgba(253, 201, 34, 0.3);
        }

        .mcf-nav-back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            color: #ffffff;
            text-decoration: none;
            font-weight: 600;
            padding: 0.3rem 0.65rem;
            border-radius: 6px;
            transition: all 0.2s ease;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .mcf-nav-back-link:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(253, 192, 3, 0.5);
            color: #fdc003;
            transform: translateX(-2px);
        }

        .mcf-nav-brand-mini {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .mcf-nav-logo-mini {
            width: 22px;
            height: 22px;
            object-fit: contain;
        }

        .mcf-nav-course-label {
            font-size: 0.7rem;
            font-weight: 600;
            letter-spacing: 0.04em;
            opacity: 0.85;
        }

        @media (max-width: 480px) {
            #mcf-tools-nav-bar {
                padding: 0.35rem 0.65rem;
            }
            .mcf-nav-back-text {
                display: none;
            }
            .mcf-nav-course-label {
                display: none;
            }
            .mcf-nav-back-link::after {
                content: 'Back';
                font-size: 0.72rem;
            }
        }

        /* Push down any existing sticky header */
        #mcf-tools-nav-bar + * .mcf-header,
        #mcf-tools-nav-bar ~ .mcf-header,
        #mcf-tools-nav-bar ~ * .mcf-header,
        #mcf-tools-nav-bar ~ header {
            position: relative !important;
        }
    `;

    // Inject into page
    document.head.appendChild(style);
    document.body.insertBefore(navBar, document.body.firstChild);
})();
