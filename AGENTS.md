# gazaka.com

Astro static site. The front door: a dark, quiet landing page and living CV for
Gareth Southern, with links out to projects including TardisXI.

## Rules

- **This is public.** Anything committed here is published to the internet under
  Gaz's real name. Never publish without explicit approval, and never include
  host details, internal ports, paths, credentials, or anything about the home
  lab's internal layout.
- Build: `npm run build` (Astro), output to `dist/`. Deployed via `deploy/` and
  the `Dockerfile`.
- Voice on this site is Gaz's own: sharp, specific, builder-oriented, a real
  person with taste. No corporate sludge, no fake enthusiasm, no "in today's
  fast-paced world". If drafting copy, match the existing pages.

## Exposure

Served through the cloudflared tunnel pattern used for the other public
surfaces. Public surfaces are inventoried in `~/.hermes/ussm/attacksurface.json`
and audited on cadence; if the deployment shape changes, update that inventory.
