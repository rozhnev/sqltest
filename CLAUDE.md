# sqltest.online

## Localization

The site is multilingual (en, ru, pt, fr, zh, es; English is the fallback).

- Never branch on the language in templates (no `{if $Lang === 'ru'}...{else}...{/if}`) or in PHP (no `$this->lang === 'ru' ? ... : ...`).
- Page text goes into separate per-language templates: a shared shell in `templates/` (layout, styles, JS, logic) includes `templates/{lang}/<name>.tpl` with the text. See `interview-start.tpl` / `templates/en/interview-start.tpl`.
- Resolve the language template with `Controller::localizedTemplate('<name>.tpl')`, which falls back to `en/` when a language has no version yet. Don't hard-code `"{$Lang}/<name>.tpl"`.
- `translations/{lang}.php` (`{translate}` block, `Localizer::translateString()`) is only for short strings used from PHP code (page titles, error messages) or shared site-wide UI labels. Don't use it for whole-page text: that means too many keys.
- Add new text at least in `en` and `ru`.

## PHP

- The production server has no `mbstring` extension: don't use `mb_*` functions (`mb_strlen`, `mb_substr`, `mb_strrpos`, …). For UTF-8 text use PCRE with the `/u` modifier, as `Question::checkFreeAnswer()` and `Lesson::firstParagraph()` do: length `preg_match_all('/./us', $s)`, first N characters `preg_match('/^.{0,N}/us', $s, $m)`.
