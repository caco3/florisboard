---
description: How to add a new keyboard layout
---

# How to add a new keyboard layout

All built-in layouts live under
`app/src/main/assets/ime/keyboard/org.florisboard.layouts/`.
The two files you always touch are:

| File | Purpose |
|------|---------|
| `layouts/characters/<id>.json` | The key grid for the new layout |
| `extension.json` | Registry — makes the layout visible to the app |

Optionally, if your layout needs custom modifier keys (bottom row) or
long-press popup mappings that differ from an existing locale, you will
also touch files in the `org.florisboard.localization/` extension.

---

## Step 1 — Create the layout JSON file

Create `layouts/characters/<your_layout_id>.json`.
The file is a **JSON array of rows**, where each row is an array of key
objects.

### Minimal example (`layouts/characters/my_layout.json`)

```json
[
  [
    { "$": "auto_text_key", "code": 113, "label": "q" },
    { "$": "auto_text_key", "code": 119, "label": "w" },
    { "$": "auto_text_key", "code": 101, "label": "e" }
  ],
  [
    { "$": "auto_text_key", "code":  97, "label": "a" },
    { "$": "auto_text_key", "code": 115, "label": "s" },
    { "$": "auto_text_key", "code": 100, "label": "d" }
  ],
  [
    { "$": "auto_text_key", "code": 122, "label": "z" },
    { "$": "auto_text_key", "code": 120, "label": "x" },
    { "$": "auto_text_key", "code":  99, "label": "c" }
  ]
]
```

### Key object fields

| Field | Type | Meaning |
|-------|------|---------|
| `$` | string | Key variant selector — see table below |
| `code` | int | Unicode codepoint of the character (decimal) |
| `label` | string | Visible label on the key |
| `type` | string | Optional — `"numeric"`, `"modifier"`, `"enter_editing"`, `"system_gui"` |
| `groupId` | int | Optional — groups keys for unified width calculation |
| `popup` | object | Optional — inline long-press popup (see below) |

### `$` variant selectors

| Value | Meaning |
|-------|---------|
| `auto_text_key` | Normal character key; casing handled automatically |
| `shift_state_selector` | Different key depending on Shift state (`default`, `shiftedManual`) |
| `variation_selector` | Different key depending on input type (`default`, `email`, `uri`) |
| `case_selector` | Different key depending on case (`lower`, `upper`) |
| `layout_direction_selector` | Different key depending on layout direction (`ltr`, `rtl`) |

### Inline long-press popup

Add a `"popup"` object to any key to define its long-press options:

```json
{ "$": "auto_text_key", "code": 101, "label": "e",
  "popup": {
    "main": { "$": "auto_text_key", "code": 233, "label": "é" },
    "relevant": [
      { "$": "auto_text_key", "code": 232, "label": "è" },
      { "$": "auto_text_key", "code": 234, "label": "ê" }
    ]
  }
}
```

`main` is the primary long-press key (shown prominently); `relevant` is
the ordered list of additional choices.

Long-press keys can alternatively be provided globally for a locale via a
popup-mapping file (see Step 4), which is the preferred approach for
language-based accents.

---

## Step 2 — Register the layout in `extension.json`

Open `extension.json` and add an entry to the `"characters"` array
(alphabetical order by `id` is the convention):

```json
{
  "id": "my_layout",
  "label": "My Layout",
  "authors": [ "your-github-username" ],
  "direction": "ltr"
}
```

### Entry fields

| Field | Required | Meaning |
|-------|----------|---------|
| `id` | yes | Must match the JSON filename without the `.json` extension |
| `label` | yes | Human-readable name shown in the layout picker |
| `authors` | yes | List of GitHub usernames |
| `direction` | yes | `"ltr"` or `"rtl"` |
| `modifier` | no | Reference to a `charactersMod` layout to override the bottom modifier row. Format: `"org.florisboard.layouts:<charactersMod_id>"`. Omit to use the default modifier row. |

### Layout type sections in `extension.json`

Most new layouts only need an entry in `"characters"`. The full list of
sections mirrors `LayoutType`:

| Section | Description |
|---------|-------------|
| `characters` | Main alpha key grid |
| `charactersMod` | Bottom modifier row (Shift, Space, Enter, etc.) |
| `numericRow` | Optional digit row above the main grid |
| `symbols` / `symbols2` | Symbol pages |
| `symbolsMod` / `symbols2Mod` | Modifier row on symbol pages |
| `numeric` / `numericAdvanced` | Numeric-only input mode |
| `phone` / `phone2` | Phone dialpad |
| `extension` | Misc extension rows (e.g. clipboard cursor row) |

---

## Step 3 (optional) — Custom modifier row (`charactersMod`)

If your layout needs a bottom row that differs from the default (e.g. a
different comma/period variant, or script-specific punctuation), create
`layouts/charactersMod/<your_mod_id>.json` and register it in the
`"charactersMod"` section of `extension.json`, then reference it via
`"modifier": "org.florisboard.layouts:<your_mod_id>"` in the
`"characters"` entry.

The modifier row JSON contains two rows:
1. Row with Shift, placeholder, and Delete.
2. Row with Symbols toggle, Comma/variation, Language switch, Media key,
   Space, Period, Enter.

Use `layouts/charactersMod/default.json` as the baseline template.

---

## Step 4 (optional) — Popup mapping for a new locale

Long-press accents/alternates are defined per locale in
`org.florisboard.localization/popupMappings/<locale_tag>.json`.

If you are adding a layout for a **language that already has a popup
mapping** (e.g. `de.json` for German), no action is needed.

If you are adding a **new language**, create
`org.florisboard.localization/popupMappings/<locale_tag>.json` and
register it in
`org.florisboard.localization/extension.json` under `"popupMappings"`:

```json
{ "id": "xy", "authors": [ "your-github-username" ] }
```

The popup mapping file maps base characters to their long-press
alternatives. Example structure:

```json
{
  "all": {
    "a": {
      "main": { "$": "auto_text_key", "code": 228, "label": "ä" },
      "relevant": [
        { "$": "auto_text_key", "code": 229, "label": "å" }
      ]
    }
  },
  "uri": {
    "~right": {
      "main": { "code": -255, "label": ".com" },
      "relevant": [
        { "code": -255, "label": ".xy" }
      ]
    }
  }
}
```

`"all"` applies to all input variation modes; `"uri"` overrides keys
when the input field expects a URL. The special key `"~right"` targets
the rightmost key of the bottom modifier row.

---

## Step 5 (optional) — Subtype preset for a new locale

A subtype preset wires a language tag to default layout/composer/currency
choices shown to the user on first setup. Add it to
`org.florisboard.localization/extension.json` under `"subtypePresets"`:

```json
{
  "languageTag": "xy-XY",
  "composer": "org.florisboard.composers:appender",
  "currencySet": "org.florisboard.currencysets:dollar",
  "popupMapping": "org.florisboard.localization:xy",
  "preferred": {
    "characters": "org.florisboard.layouts:my_layout"
  }
}
```

Use `"preferred"` to specify non-default layouts for `symbols`,
`symbols2`, or `numericRow` when needed (see the `fa-FA` or
`de-DE-neobone` entries for examples).

---

## Summary checklist

- [ ] `layouts/characters/<id>.json` — key grid created
- [ ] `extension.json` (`org.florisboard.layouts`) — entry added under `"characters"`
- [ ] *(if custom bottom row)* `layouts/charactersMod/<mod_id>.json` created and registered
- [ ] *(if new language)* `popupMappings/<locale>.json` created and registered in `org.florisboard.localization/extension.json`
- [ ] *(if new language)* `subtypePresets` entry added in `org.florisboard.localization/extension.json`
- [ ] Build and test the layout on a device or emulator
