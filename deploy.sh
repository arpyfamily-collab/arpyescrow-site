#!/bin/bash
# ═══════════════════════════════════════════════════════════════
# ArpyEscrow Static Site — GitHub Pages Deploy Script
# ═══════════════════════════════════════════════════════════════
# 
# USAGE:
#   ./deploy.sh
#
# PREREQUISITES:
#   1. Git installed
#   2. GitHub CLI (gh) installed and authenticated
#      Install: https://cli.github.com
#      Auth:    gh auth login
#
# WHAT THIS SCRIPT DOES:
#   1. Creates a new GitHub repo called "arpyescrow-site"
#   2. Pushes all files to it
#   3. Enables GitHub Pages
#   4. Prints next steps for Cloudflare DNS
#
# ═══════════════════════════════════════════════════════════════

set -e

REPO_NAME="arpyescrow-site"
DOMAIN="arpyescrow.com"

echo ""
echo "═══════════════════════════════════════════════════"
echo "  ArpyEscrow — GitHub Pages Deployment"
echo "═══════════════════════════════════════════════════"
echo ""

# Check for gh CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "   Install it: https://cli.github.com"
    echo "   Then run:   gh auth login"
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null 2>&1; then
    echo "❌ Not authenticated with GitHub CLI."
    echo "   Run: gh auth login"
    exit 1
fi

GITHUB_USER=$(gh api user -q '.login')
echo "✓ Authenticated as: $GITHUB_USER"
echo ""

# Initialize git if needed
if [ ! -d ".git" ]; then
    echo "→ Initializing git repository..."
    git init -b main
    echo "✓ Git initialized"
fi

# Stage and commit all files
echo "→ Staging all files..."
git add -A
git commit -m "Deploy ArpyEscrow static site — About, Contact, 3 SEO articles, homepage, 404, sitemap" 2>/dev/null || echo "✓ Already committed"

# Create GitHub repo (or use existing)
echo "→ Creating GitHub repository: $REPO_NAME..."
if gh repo view "$GITHUB_USER/$REPO_NAME" &> /dev/null 2>&1; then
    echo "✓ Repository already exists"
else
    gh repo create "$REPO_NAME" --public --description "ArpyEscrow — NY Real Estate Transaction Platform — Static Site" --source=. --push
    echo "✓ Repository created and pushed"
fi

# Set remote and push
if ! git remote get-url origin &> /dev/null 2>&1; then
    git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"
fi
echo "→ Pushing to GitHub..."
git push -u origin main 2>/dev/null || git push --force origin main

# Enable GitHub Pages
echo "→ Enabling GitHub Pages on main branch..."
gh api -X PUT "repos/$GITHUB_USER/$REPO_NAME/pages" \
  -f "source[branch]=main" \
  -f "source[path]=/" \
  --silent 2>/dev/null || \
gh api -X POST "repos/$GITHUB_USER/$REPO_NAME/pages" \
  -f "source[branch]=main" \
  -f "source[path]=/" \
  --silent 2>/dev/null || \
echo "  (Pages may already be enabled — check Settings → Pages)"

echo ""
echo "═══════════════════════════════════════════════════"
echo "  ✓ DEPLOYMENT COMPLETE"
echo "═══════════════════════════════════════════════════"
echo ""
echo "  GitHub repo:  https://github.com/$GITHUB_USER/$REPO_NAME"
echo "  Pages URL:    https://$GITHUB_USER.github.io/$REPO_NAME/"
echo ""
echo "═══════════════════════════════════════════════════"
echo "  NEXT: CLOUDFLARE DNS SETUP"
echo "═══════════════════════════════════════════════════"
echo ""
echo "  1. Log into Cloudflare → select arpyescrow.com"
echo ""
echo "  2. Go to DNS → Records and set:"
echo ""
echo "     Type   Name    Content              Proxy"
echo "     ─────  ──────  ───────────────────   ─────"
echo "     A      @       185.199.108.153       ON"
echo "     A      @       185.199.109.153       ON"
echo "     A      @       185.199.110.153       ON"
echo "     A      @       185.199.111.153       ON"
echo "     CNAME  www     $GITHUB_USER.github.io  ON"
echo ""
echo "  3. Go to SSL/TLS → set mode to 'Full'"
echo ""
echo "  4. Go to Rules → Redirects → Bulk Redirects:"
echo "     Add these .html → clean URL redirects:"
echo ""
echo "     /ny-attorney-review-period.html → /ny-attorney-review-period (301)"
echo "     /ny-real-estate-deal-room.html  → /ny-real-estate-deal-room  (301)"
echo "     /45-day-mortgage-commitment.html → /45-day-mortgage-commitment (301)"
echo ""
echo "  5. Wait 5-10 minutes, then verify:"
echo "     https://arpyescrow.com"
echo "     https://arpyescrow.com/about"
echo "     https://arpyescrow.com/contact"
echo ""
echo "═══════════════════════════════════════════════════"
echo ""
