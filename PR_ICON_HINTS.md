# feat: Support icon hints for `system_gui` keys

## Summary

This PR enables keyboard layout authors to assign **icon hints** to character keys by placing `system_gui` action keys in the symbols layout row that aligns with the character row.

Previously, hints were always rendered as text labels. Special action keys (clipboard, smartbar toggle, settings, etc.) have icons via `computeImageVector` but no meaningful text label — so they either showed an internal label string or nothing at all in the hint position.

## Changes

### `Key.kt`
Added `hintedImageVector: ImageVector?` field alongside the existing `hintedLabel`. This stores the icon to render in the hint position when the hint key is a system action rather than a character.

### `TextKey.kt`
In `computeLabelsAndDrawables`:
- When the resolved hint (`symbolHint` / `numberHint`) has a **negative key code** (all system_gui action keys use negative codes), `computeImageVector` is called and the result stored in `hintedImageVector` instead of setting `hintedLabel`.
- When no symbol/number hint exists, the existing fallback to `computedPopups.main` is extended: if `main` has a negative code and `computeImageVector` returns a non-null icon, that icon is used as the hint.
- `hintedImageVector` is cleared alongside `hintedLabel` on each recompute.

### `TextKeyboardLayout.kt`
Added rendering of `hintedImageVector` as a `SnyggIcon` in the hint position (`BiasAlignment(0.85f, -0.7f)`, 11dp) when present, using the `KeyHint` style element.

Added missing imports: `androidx.compose.foundation.layout.size` and `androidx.compose.ui.unit.dp`.

### `LayoutManager.kt`
`addRowHints` now also accepts `KeyType.SYSTEM_GUI` keys as symbol hints (in addition to `KeyType.CHARACTER`), enabling layouts to place system action keys in the symbols row to produce icon hints on character keys.

## Use Case Example

A symbols layout row can place `{ "code": -241, "type": "system_gui" }` (smartbar toggle) at a specific column. The character key in the same column will then show the smartbar-toggle icon as a hint and execute the action on long-press.

## Backwards Compatibility

- Keys with positive-code hints continue to render text labels exactly as before.
- Keys with no applicable hint are unaffected.
- No JSON schema changes required; existing layouts work unchanged.
