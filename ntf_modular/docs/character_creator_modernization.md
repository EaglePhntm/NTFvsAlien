# Character Creator Modernization

This project is moving the old preferences UI toward a modular character
creator without rewriting the whole window at once.

The old pattern mixed several responsibilities:

- TGUI displayed human labels such as `Human`.
- Preferences stored sprite ids such as `human`.
- DM assoc lists mapped labels to ids, such as `"Human" = "human"`.
- Some controls used modal `tgui_input_list()` prompts.
- Some controls used direct TGUI dropdowns.
- Icon renderers guessed icon states from saved values.

That mixture makes bugs likely: the sprite can update while the visible
selection text stays stale, or an option list can disappear from the TGUI
payload.

## Current UI Shape

The character customization page is now a modular island inside the older
preferences window.

The current layout is:

- Left side: character preview and rotation controls.
- Right side: focused creator tabs.
- Tabs: `Identity`, `Appearance`, `Species`, `Features`, `Markings`, and
  `Voice`.

The old four-direction preview strip was replaced with one preview panel. The
preview can be rotated with TGUI actions instead of opening separate modal
flows. Rotation actions are debounced in TGUI because older preference actions
can briefly close and reopen the preferences window if clicked too quickly.

The preview is still backed by the old preference dummy system. Avoid trying to
scale the dummy transform directly: SPLURT's current direction is to keep mobs
native and change the preview canvas/resources around them. The NTF preview is
intentionally conservative for now because transform scaling caused pixelation
and alignment drift.

## Current Pattern: Modular Rows

Genital customization and body-part customization are now modular islands. The
backend sends flat top-level row data instead of nested row objects. This is
intentional: older BYOND/TGUI serialization can turn nested lists into
numeric-key objects or drop shapes in ways that are hard to debug.

Each row follows this contract:

- `id`: stable preference/action id, such as `genitalia_cock`.
- `label`: user-facing row label, such as `Penis`.
- `value`: stored sprite id, such as `human`.
- `display`: user-facing selected label, such as `Human`.
- `option_labels`: user-facing dropdown labels.
- `option_values`: stored sprite ids paired by index with `option_labels`.
- `size_id`: optional size preference/action id.
- `size_value`: optional current size display value.
- `size_kind`: optional size renderer hint.
- `size_min` / `size_max`: optional numeric size range.

Rows are discovered through:

```dm
data["character_creator_genital_row_ids"] = list("genitalia_boobs", "genitalia_ass")
data["character_creator_part_row_ids"] = list("digitigrade_legs", "moth_wings", "tail")
```

Each row then stores top-level keys:

```dm
data["character_creator_genitalia_cock_label"] = "Penis"
data["character_creator_genitalia_cock_value"] = "human"
data["character_creator_genitalia_cock_display"] = "Human"
data["character_creator_genitalia_cock_option_labels"] = list("Default", "Human")
data["character_creator_genitalia_cock_option_values"] = list("", "human")
```

TGUI renders these rows generically and sends changes through:

```ts
act('set_character_creator_value', {
  field: row.id,
  value: storedValue,
});

act('set_character_creator_part_value', {
  field: row.id,
  value: storedValue,
});
```

The DM side owns validation. TGUI sends stored values, not display labels.

## Color Rows

Accessory and feature colors are sent as row metadata and rendered by the same
generic row component. Colors are intentionally kept near their owning option
instead of being placed in one long global color list.

Typical color fields are:

```dm
data["character_creator_tail_color_count"] = 3
data["character_creator_tail_color_1"] = tail_color
data["character_creator_tail_color_2"] = tail_color_secondary
data["character_creator_tail_color_3"] = tail_color_tertiary
```

TGUI renders color swatches and sends color actions back to DM. Keep color
validation in DM. The UI should not decide which sprite layer a color maps to.

For body-part accessories, the common convention is:

- Primary: main part color.
- Secondary: detail or undertail/fluff color.
- Tertiary: accent, markings, or special highlight layer.

Genital/body feature colors use the same idea but each feature owns its own
color count. For example breasts and testicles currently use multiple colors,
while butt and belly are single-color.

## Why Labels Are Still Used By TGUI

The current `Dropdown` usage is label-oriented, so TGUI displays
`option_labels`. It uses the selected label's index to send the matching stored
value from `option_values`. This keeps display text and saved sprite ids
separate without relying on nested option objects.

## Option Registries

Character creator controls should render and validate from the same source.
That source currently lives in
`ntf_modular/code/modules/client/preferences_character_creator.dm`:

- `character_creator_genital_options(id)` owns genital labels and stored ids.
- `character_creator_part_definition(id)` owns body-part rows such as tail,
  snout, ears, horns, wings, moth wings, and digitigrade legs.
- `write_character_creator_genital_data()` and
  `write_character_creator_part_data()` serialize those rows.
- `handle_character_creator_accessory_action()` validates changes against the
  same registries before writing preference vars.

This follows the SPLURT/Bubber preference-feature philosophy while staying
compatible with the older NTF preferences window.

## Markings

Markings use the same flat serialization philosophy. The backend sends zone ids,
row ids, available choices, current selected marking, and color values. TGUI only
renders controls and returns the selected stored marking name.

Current supported marking zones are driven by DM data and include areas such as:

- Head
- Chest
- Arms
- Hands
- Legs

Each zone can own multiple marking rows. Add/remove/color actions all route back
through DM so the saved list shape stays stable.

When adding new SPLURT/Bubber marking ports, prefer adding a marking datum and
letting the existing marking serializer discover it instead of adding one-off
TGUI fields.

## Robot Customization

Combat robot appearance customization now uses a saved preference toggle:
`allow_mismatched_parts`.

The UI label is `Custom robot parts`. When enabled, it shows separate combat
robot body and head selectors. The value is saved per character slot in
`preferences_savefile.dm`, so players do not need to re-enable it every login.

The name is historical internally because it began as the old
`Allow mismatched parts` switch. New UI text should use `Custom robot parts`.
Avoid adding a second preference var unless the old one is fully migrated.

The separate `synthetic_body_base` value is for Synthetic/Early Synthetic job
appearance. The `robot_body_base` and `robot_head_base` values are for Combat
Robot custom appearance.

## Hair Rendering

Old TGMC hair coloring bakes colors into an icon with `icon.Blend()`. That works
for some older hair masks but breaks white-base SPLURT/Zubbers hairs, producing
mostly white sprites with faint tinting.

Imported SPLURT-style hairs use accessory metadata:

```dm
colouration_blend = ICON_MULTIPLY
colouration_tone = TRUE
```

`update_hair()` checks that metadata. Problem hairs render as separate
`mutable_appearance` overlays with `appearance.color`, matching SPLURT's
approach more closely. Older hair still uses the baked icon path where it
already works.

This fixes hairs such as `Inari`, `New You`, pod hairs, and other white-base
ports without forcing every legacy hair through the new path at once.

## Tail Wagging

The `*wag` emote is now a toggle.

- First `*wag`: enables wagging.
- Second `*wag`: disables wagging.
- Death: clears wagging through `stop_tail_wag()`.

Wagging uses either an explicit old lizard wagging tail datum or a
`m_waggingtail_[state]` icon prefix when that animated state exists. Do not keep
old wagging variants as normal selector options when the same tail can be
animated by the emote.

## Directional Layering

The character creator and in-world mob renderer must both respect direction.
Treat accessories as body-attached parts, not as independent sprites pivoting
around themselves.

Important current rules:

- Facing north: tail should draw in front of the body because the character's
  back is facing the viewer.
- Facing north: wings should sit between tail and body.
- Facing south: front-facing body/genital features can draw over legs/body when
  they are physically on the viewer-facing side.
- Facing east/west: wings generally draw over the body, while tail/body rules
  depend on the part attachment.
- Clothing that covers the torso/limbs needs the same north-facing demotion rule
  as uniforms and suits, otherwise gloves, belts, and other worn items can cover
  the tail incorrectly.

Relevant helper behavior currently lives around the human icon update path:

- `ntf_north_body_clothing_layer()`
- `ntf_set_worn_appearance_layer()`
- `update_accessories()`
- `update_tail()`

When adding a new body-attached overlay, decide its north/south/east/west layer
relationship up front. Most recurring visual bugs came from adding a new overlay
with a static layer and then trying to patch directions later.

## Snouts And Masks

Snouts can require special mask or facehugger states because the normal mask
sprite may sit too close to the face. The current long-term direction is to keep
snout-aware icon selection in DM, not in TGUI.

If a worn mask has a snouted variant, `update_inv_wear_mask()` should select that
icon file/state before creating the worn appearance. The UI should only expose
the snout choice and colors.

## Adding A New Genital Option

Add the display label and stored sprite id in
`character_creator_genital_options(id)`.

Example:

```dm
GLOBAL_LIST_INIT(possible_vagina_sprites, list(
  "Default" = null,
  "Human" = "human",
  "Slit" = "slit",
))
```

If the option needs rendering support, update the relevant icon-state logic in
`ntf_modular/code/modules/mob/living/carbon/human/update_icons.dm`.

If the standalone genital menu still needs the same option, also update
`ntf_modular/code/datums/genital_menu.dm`.

## Adding A New Body Part Row

Add a new entry to `character_creator_part_definition(id)`, add the id to
`character_creator_part_ids()`, and implement the render/update behavior in the
mob icon code.

For each field, prefer a row contract over adding new one-off UI code:

- Backend sends label, current display value, options, colors, and size metadata.
- TGUI renders the row generically.
- One backend action validates and stores changes.
- Rendering procs only render. Preference actions save.

## Adding A New Species Or Body Base

Prefer a staged port:

1. Add the species/body-base option.
2. Add body icon resolution and limb support.
3. Add eyes, hands, digitigrade support, and accessory compatibility.
4. Add savefile sanitization.
5. Enable the option in the UI only after the preview and in-world body both
   render acceptably.

Several SPLURT species share body bases rather than owning fully separate body
logic. For example Anthro-like species can share an Anthro body base, and
synthetic variants can route through synthetic/combat robot body-base selection.
Avoid duplicating species datums when a body-base option is the actual behavior.

Roundstart SPLURT-style species are allowed to have deliberate mechanics, but
those mechanics must be visible in the species datum. `Lizard`, `Akula`,
`Anthro`, `Aquatic`, `Insectoid`, and `Skrell` currently use claw unarmed
attacks. Claws do more unarmed damage than a punch, are sharp/edge attacks, use
slash sounds, and render with claw VFX. Do not remove those as "accidental"
unless design decides these species should become cosmetic-only.

## Disabled Species Placeholders

Some species datums are intentionally present but not selectable yet. These keep
SPLURT/Bubbers type paths, body icon wiring, savefile compatibility, and future
port targets visible without exposing unfinished species to players.

Current intentionally disabled placeholders include:

- `Humanoid`
- `Podperson`
- `Mushperson`
- `Xenomorph Hybrid`
- `Tajaran`
- `Vulpkanin`
- `Teshari`
- `Vox Primalis`

Do not remove these just because `joinable_roundstart = FALSE`. Enable one only
after its body sprites, hands, eyes, digitigrade behavior, accessory defaults,
and any species mechanics are working in both the preview and in world.

Copied Skyrat bodypart code files are not used by NTF's current renderer. Keep
only the icon sheets and data that the NTF code references directly. Species
that are not on the roadmap, such as dwarf, ghoul, and golem, should be removed
instead of kept as disabled placeholders.

`Prototype Supersoldier` is not a placeholder. Its core mechanics live in the
upstream species/action files: it gets the supersoldier stim action, the tall
trait, and a lower crit threshold while that species is active.

Prototype supersoldiers can optionally use custom body/head bases through
`custom_supersoldier_parts`, `supersoldier_body_base`, and
`supersoldier_head_base`. This mirrors the combat robot custom-part flow, but it
uses organic SPLURT body bases instead of robot manufacturer bodies.

## Savefile Rule

Every new visible character option needs four pieces:

- A var in preferences/human data.
- TGUI data output.
- UI action handling.
- Load, sanitize, and save entries in `preferences_savefile.dm`.

If any one of those is missing, the UI may appear to work until relog, slot
switch, or server restart.

## Important Rule

Do not add new complex controls to the legacy modal-button pattern unless there
is no practical alternative. New customization should use explicit row data and
generic TGUI rendering.

Legacy controls can remain while they are stable, but new feature work should
prefer modular rows, DM-owned registries, and Skyrat/Bubbers/Splurt-style rendering rules.
