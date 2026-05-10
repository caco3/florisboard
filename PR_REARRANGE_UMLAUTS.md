# feat: Rearrange Swiss German layout - move umlauts to separate rows

## Summary

This PR reorganizes the Swiss German (de-CH) character layout to distribute the umlaut keys (ä, ö, ü) across different rows instead of clustering them on the first two rows. This improves the layout balance and allows for more consistent button widths.

## Changes

### Character Layout (`layouts/characters/swiss_german_CaCO3.json`)

| Row | Before | After | Count |
|-----|--------|-------|-------|
| 1 (q-row) | q,w,e,r,t,z,u,i,o,p,**ü** (11 keys) | q,w,e,r,t,z,u,i,o,p (10 keys) | 10 |
| 2 (a-row) | a,s,d,f,g,h,j,k,l,**ö**,**ä** (11 keys) | a,s,d,f,g,h,j,k,l,**ä** (10 keys) | 10 |
| 3 (y-row) | y,x,c,v,b,n,m (7 keys) | y,x,c,v,b,n,m,**ö** (8 keys) | 8 |

### Modifier Row (`layouts/charactersMod/default.json`)
- Add **ü** after space key with è popup for long-press

### Symbols Layout (`layouts/symbols/western_caco3.json`)
- Move **ë** to row 0, column 9 to provide hint for **ä** at row 2, column 9
- Remove redundant ë from symbols row 1

### Popup Mappings (`popupMappings/de-CH.json`)
- Add **ö** entry with **é** as main popup (long-press shows é)
- **ü** entry with **è** as main popup (already present)

## Layout Visualization

```
Row 1:  [q] [w] [e] [r] [t] [z] [u] [i] [o] [p]        (10 keys)
Row 2:  [a] [s] [d] [f] [g] [h] [j] [k] [l] [ä]        (10 keys, ä has ë hint)
Row 3:  [y] [x] [c] [v] [b] [n] [m] [ö]               (8 keys, wider buttons)
Mod:    [shift] [...] [space] [ü] [...] [enter]       (ü has è popup)
```

## Benefits

1. **Consistent row 1-2 widths**: Both top rows now have exactly 10 keys with equal button widths
2. **Better thumb reach**: ü on bottom row is easier to reach with thumb
3. **Visual balance**: ö on row 3 fills out the shorter row (7→8 keys)
4. **Preserved functionality**: All umlauts retain their long-press alternatives (ë, é, è)

## Backwards Compatibility

This is a new layout file (`swiss_german_CaCO3.json`) that must be explicitly selected in settings. Existing layouts are unaffected.
