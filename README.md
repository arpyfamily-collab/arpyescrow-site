# ArpyEscrow — Static Site

New York Real Estate Transactions. Done Right, Done Fast.

**ArpyEscrow** is an attorney-built transaction management platform for New York residential real estate. This repository contains the public-facing static site hosted via GitHub Pages + Cloudflare.

## Pages

| Page | URL | Purpose |
|------|-----|---------|
| Homepage | `/` | Landing page with value props and CTAs |
| About | `/about` | Platform overview, team, mission |
| Contact | `/contact` | Email, LinkedIn, Instagram, contact form |
| Attorney Review | `/ny-attorney-review-period` | SEO article: NY contract review process |
| Deal Room | `/ny-real-estate-deal-room` | SEO article: digital deal rooms |
| Mortgage Commitment | `/45-day-mortgage-commitment` | SEO article: 45-day deadline guide |
| 404 | `/404.html` | Custom error page |

## Deployment

```bash
./deploy.sh
```

Requires [GitHub CLI](https://cli.github.com) authenticated via `gh auth login`.

## Stack

- **Hosting:** GitHub Pages (free)
- **CDN/DNS/SSL:** Cloudflare (free)
- **App:** [app.arpyescrow.com](https://app.arpyescrow.com) (Base44)

## SEO

- `sitemap.xml` — All 6 public pages
- `robots.txt` — Points crawlers to sitemap
- `CNAME` — Custom domain binding
- Schema.org structured data on every page (Article, FAQPage, Organization, SoftwareApplication)
- Open Graph + Twitter Card meta tags on every page

## Links

- **App:** [app.arpyescrow.com](https://app.arpyescrow.com)
- **LinkedIn:** [Brian Butler](https://www.linkedin.com/in/brian-b-7ab125315/)
- **Instagram:** [@ArpyEscrow](https://www.instagram.com/ArpyEscrow/)
- **Email:** b@arpyflow.com

---

© 2026 ArpyEscrow. Built by attorneys, for attorneys.
