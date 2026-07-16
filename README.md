# gazaka.com

The front door. A dark, quiet landing page for Gareth Southern — living CV,
project showcase, and a public notebook.

Built with [Astro](https://astro.build) → pure static HTML/CSS, served by
unprivileged nginx in a read-only container, exposed only through cloudflared.

## Writing a blog post

Create a markdown file in `src/content/blog/`:

```markdown
---
title: My post title
date: 2026-08-01
summary: One line shown in the post list. Optional.
---

Write whatever is rattling around your head.
```

Then:

```bash
git add . && git commit -m "post: my post title" && git push
```

Live in ~2 minutes. Set `draft: true` in the frontmatter to keep a post
unpublished while you work on it.

## Adding / editing a project

Same idea — files live in `src/content/projects/`. Frontmatter:

```yaml
name: Project Name
tagline: One italic line under the title.
status: live | in progress | brewing | archived
stack: [Lua, MySQL]
order: 4        # sort position on the page
hidden: false   # true = built but not shown
```

## Editing the CV / about content

- Bio, day-job and journey copy: `src/pages/index.astro`
- Name, email, social links: `src/data/site.ts`
- Qualifications list ("On paper"): `src/pages/index.astro`

## Local development

```bash
npm install
npm run dev        # http://localhost:4321
npm run build      # output in dist/
```

## How deployment works

```
git push → GitHub Actions builds the container → pushes to ghcr.io (private)
         → watchtower on the server notices within 2 min → pulls & restarts
```

Nothing on the server ever needs touching to publish.

## One-time server setup

1. **GHCR login** (the image is private). Create a GitHub PAT (classic) with
   only the `read:packages` scope, then on the server:

   ```bash
   docker login ghcr.io -u gazaka   # paste the PAT as the password
   ```

2. **Start the stack:**

   ```bash
   mkdir -p ~/gazaka.com-deploy
   # copy deploy/docker-compose.yml there
   cd ~/gazaka.com-deploy && docker compose up -d
   ```

   The site is now on `127.0.0.1:8085` — localhost only, nothing exposed.

3. **Point cloudflared at it.** In the tunnel config (`config.yml` ingress or
   the Zero Trust dashboard), add:

   ```yaml
   - hostname: gazaka.com
     service: http://localhost:8085
   ```

   Restart cloudflared. Done.

## Security posture

- Static files only — no runtime, no database, no login surface.
- nginx runs unprivileged (uid 101), container is `read_only` with all
  capabilities dropped and `no-new-privileges`.
- Bound to `127.0.0.1` — only cloudflared can reach it; TLS terminates at
  Cloudflare.
- Security headers (CSP, nosniff, frame-ancestors none, etc.) on every
  response; fingerprinted assets cached immutable, HTML always revalidated.
- No third-party requests at all: fonts are self-hosted, no analytics, no CDN.
