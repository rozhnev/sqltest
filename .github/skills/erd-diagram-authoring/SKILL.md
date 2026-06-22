---
name: erd-diagram-authoring
description: "Use when creating, editing, or reviewing ERD diagrams in this repository, especially AdventureWorks SVG ERDs. Covers table naming, connector routing, non-crossing rules, and theme parity between light and dark diagrams."
---

# ERD Diagram Authoring

## Purpose

This skill is for creating and maintaining ERD diagrams in this repository.

Use it when you need to:

- create a new ERD for a database page;
- update existing ERD table positions;
- add, remove, or reroute relationships;
- fix misleading or crossing connectors;
- keep light and dark ERD variants synchronized.

This skill is repository-specific and should follow the existing ERD rendering approach used by SVG files in `images/` and the ERD viewer template in `templates/erd.tpl`.

## File and Naming Conventions

- ERD assets are loaded by database name from `templates/erd.tpl`.
- Primary output files should be:
  - `images/erd_<db>.svg`
  - shared stylesheet `css/erd.css`
- Keep one SVG geometry per database and style light/dark variants via CSS variables in the shared stylesheet.

## Core Rules

- Use schema-case table titles (for example: `Address`, `CustomerAddress`, `SalesOrderHeader`), not all caps.
- Keep one connector per foreign key.
- Do not merge multiple FK relationships into a single visual line.
- Avoid shared connector segments that can imply a false relationship.
- Route connectors outside table bodies; arrowheads should terminate on table borders.
- Prefer non-crossing paths over shortest possible paths.

## AdventureWorks Layout Notes

For the current AdventureWorks ERD baseline:

- `CustomerAddress` is placed under `Address`.
- `ProductDescription` is placed in the middle-right area.
- `SalesOrderHeader -> Address` uses two separate parallel connectors:
  - `ShipToAddressID`
  - `BillToAddressID`
- The two connectors above should terminate near the vertical middle of the left border of the `Address` table.

## Connector Design Guidance

- Use orthogonal (elbow) paths for readability.
- Keep label placement close to its own connector and away from table text.
- If a reroute risks ambiguity, add another lane instead of reusing an existing lane.
- Preserve visual direction: child table connector points to parent table.

## Editing Workflow

1. Confirm FK relationships from the source template (for example `templates/en/adventureworks.tpl`).
2. Update table block positions first.
3. Reroute only affected connectors.
4. Ensure the updated SVG uses the shared stylesheet and the proper `erd-<db>` class for scoped overrides.
5. Validate both files with:

```bash
xmllint --noout images/erd_<db>.svg
```

6. Verify visually that:
- no connector crosses table bodies;
- no connector implies unrelated relationships;
- each FK has exactly one distinct line.

## Quality Checklist

- Table names match schema casing.
- No accidental all-caps table headers.
- No crossed-through table rectangles.
- No shared connector segment between unrelated relationships.
- Theme parity preserved between light and dark files.
- SVG syntax passes `xmllint`.

## Sakila ERD Specific Rules

### Typography & Responsive Design

- Use CSS `clamp()` for adaptive font sizing instead of fixed pixels or media queries.
- Format: `clamp(min-size, preferred-expr, max-size)` (e.g., `clamp(14px, 0.45vw + 12px, 18px)`)
- Define separate variables for each text class: title, col, key, label, main, sub, legend-title.
- Ensures legibility on mobile while preventing overflow on desktop.

### Dark Theme Contrast

- Ensure adequate contrast in dark mode by brightening secondary text colors.
- Key color variables to adjust:
  - `--erd-col`: column names (increase brightness for legibility)
  - `--erd-label`: connector labels
  - `--erd-sub`: secondary text
  - `--erd-pk` and `--erd-fk`: key badges (use cyan/purple variants for dark)
- Test both light and dark themes to confirm text readability.

### Field Layout

- Place each database column on a separate text row within table blocks.
- Prevents text cramping and improves mobile readability.
- Adjust table height based on field count.

### Connector Routing

- Prefer horizontal straight lines (orthogonal connectors) over diagonals.
- Attach connectors at the **middle (vertical center) of table edges** rather than corners.
- Calculate Y-coordinate for mid-height: `table_y + (table_height / 2)`.
- Route complex paths (e.g., inventory→store) **above or beside tables** to avoid crossing table bodies.
- Example: Inventory→Store routes up to Y=20, across right, then down to store.

### Legend & Layout

- Expand legend box width when needed (Sakila uses 420px for 4+ items).
- Maintain consistent grid spacing for table rows (80px gap recommended).

## Sakila Database Layout Reference

Current table positions (Sakila database, erd_sakila.svg):
- Row 1 (Y=80): country, city, address, store, staff
- Row 2 (Y=520): language | Row 2b (Y=400): film_actor, film, inventory | Row 2c (Y=620): actor, film_category, category
- Row 3 (Y=770): customer, rental
- Row 4 (Y=1050): payment, legend

Key connector rules for this layout:
- **address→city**: Horizontal at table middle (Y=178)
- **store→address**: Horizontal at PK level (Y=133)
- **film_actor→film**: Horizontal at table middle (Y=454)
- **film_category→film**: Horizontal at table middle (Y=674)
- **customer→store/address**: Route from customer middle (Y=890) to respective table attachment points
- **inventory→store**: Route up-right-down path to avoid crossing film/customer tables
