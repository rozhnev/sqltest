# TODO: Site-wide typography

Lessons got new typography first (`css/lesson.css`, block "Lesson typography"). Measured on
`/ru/lesson/getting-started/introduction-to-databases`:

| | Before | Lessons now |
|---|---|---|
| Font | `"Lucida Grande", Tahoma, Arial, Verdana, sans-serif` (differs per OS) | System font stack |
| Text, desktop | 16px / 24px | 17px / 28px (1.65) |
| Line length | full column width | full column width (not limited, by decision) |
| Headings | `line-height: normal`, equal margins above and below | `line-height: 1.25`, more space above than below; H1 `clamp(1.6rem, 5vw, 2rem)` |
| List items | `padding-top: 1em` | `margin: 0.45em 0` |
| Phone text | 16px / 24px, H1 32px | 16px / 26px, H1 25.6px |

The rest of the site still uses the old settings. To do:

## Site-wide typography: done

- [x] `style.css`: `--font-sans` / `--font-mono` variables in `:root`; `body` uses the system font stack.
- [x] `code`, `kbd`, `samp`, `pre` use `--font-mono` at `0.875em` (the bare generic `monospace` used to make the
      browser shrink them to 13px; a named font stack doesn't, so the size is explicit now).
- [x] Task text (`.question pre`): text font and size instead of Arial.
- [x] SQL names (`.sql`): `x-large` / `large` replaced with the sizes they had (`1.25rem` / `0.975rem`).
- [x] Content pages (`.about .section`: about, privacy policy, donate, test start): `line-height: 1.6`
      instead of `normal`.
- [x] Playground intro text: `0.95rem` instead of the column's ~13px.
- [x] `css/lesson.css`: no own font families any more (inherited), inline code size from `style.css`.
- [x] `css/donate.css`: crypto address uses `--font-mono`.
- [x] Minify workflow builds `css/playground.min.css` too (it was only listed as a trigger).

## Still to check or decide

- [ ] Phones (`m.` templates): menus and buttons with the narrower system font.
- [ ] Windows (Segoe UI) and Android (Roboto), Cyrillic and Chinese pages.
- [ ] Interview pages, books, profile, buy-tokens, admin: only the font changed; look them over.
- [ ] Admin panel (`admin/style.css`) has its own font (`Space Grotesk`, `Inter`, …): leave or align.
- [ ] Optional: move the lesson typography block into a reusable `.prose` class if other long-text pages
      should get 17px / 1.65 too.

## Also pending from the lesson page UX review

- [ ] One donation request per page (banner or side card), shorter donation card with "Подробнее" to `/donate`.
- [ ] H1 first on the lesson page (before "Урок 1.1 · Время чтения" and the intro).
- [ ] In-page contents for long lessons; prev/next under the title; "mark as read" with progress in the menu.
- [ ] Practice tasks as a visible call to action, mentioned in the intro.
- [ ] AI panel for guests: say that the first questions are free; sticky panel on desktop.
- [ ] Top menu items and modal titles are `<h2>`: make them plain text (heading order starts with H1).
- [ ] Lesson images: `width`/`height` and `loading="lazy"`.

Done: CloudTips removed from the lesson sidebar; urgent banner hidden on phones; course menu drawer on phones;
footer no longer fixed on lessons; lesson tables restyled; mobile horizontal scroll fixed.
