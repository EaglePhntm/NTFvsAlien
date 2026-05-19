import {
  Box,
  Button,
  ColorBox,
  Dropdown,
  Flex,
  LabeledList,
  Section,
  Tabs,
} from 'tgui-core/components';

import { useBackend, useLocalState } from '../../backend';
import {
  SelectFieldPreference,
  TextFieldPreference,
  ToggleFieldPreference,
} from './FieldPreferences';
import { ProfilePicture } from './ProfilePicture';

export const CharacterCustomization = (props) => {
  const { act, data } = useBackend<CharacterCustomizationData>();
  const [activeCreatorPanel, setActiveCreatorPanel] = useLocalState(
    'characterCreatorPanel',
    'appearance',
  );
  const [lastPreviewRotate, setLastPreviewRotate] = useLocalState(
    'characterCreatorLastPreviewRotate',
    0,
  );
  const [lastRobotToggle, setLastRobotToggle] = useLocalState(
    'characterCreatorLastRobotToggle',
    0,
  );
  const [lastNameRandomize, setLastNameRandomize] = useLocalState(
    'characterCreatorLastNameRandomize',
    0,
  );
  const {
    random_name,
    gender,
    physique,
    r_hair,
    g_hair,
    b_hair,
    r_grad,
    g_grad,
    b_grad,
    r_eyes,
    g_eyes,
    b_eyes,
    r_facial,
    g_facial,
    b_facial,
  } = data;

  const rgbToHex = (red, green, blue) => {
    const convert = (comp) => {
      const hex = comp.toString(16);
      return hex.length === 1 ? `0${hex}` : hex;
    };
    return '#' + convert(red) + convert(green) + convert(blue);
  };
  const colorSwatchButton = (color, action, tooltip) => (
    <Button compact tooltip={tooltip} onClick={() => act(action)}>
      <ColorBox color={color} />
    </Button>
  );
  const colorField = (label, color, action) => (
    <LabeledList.Item label={label}>
      {colorSwatchButton(color, action, color)}
    </LabeledList.Item>
  );
  const compactDropdown = (
    selected,
    options,
    action,
    valueForLabel?,
    width = '70px',
  ) => (
    <Box as="span" style={{ minWidth: width }}>
      <Dropdown
        options={options}
        selected={selected}
        displayText={selected}
        onSelected={(choice) =>
          act(action, { newValue: valueForLabel ? valueForLabel[choice] : choice })
        }
      />
    </Box>
  );
  const numberedSizeDropdown = (value, action, minValue, maxValue) => {
    const labels = Array.from(
      { length: maxValue - minValue + 1 },
      (_, index) => `${minValue + index}`,
    );
    const valuesByLabel = Object.fromEntries(
      labels.map((label) => [label, Number(label)]),
    );
    return compactDropdown(`${value ?? minValue}`, labels, action, valuesByLabel);
  };
  const penisSizeLabels = Array.from(
    { length: 7 },
    (_, index) => `${index * 10}-${(index + 1) * 10}`,
  );
  const penisSizeValues = Object.fromEntries(
    penisSizeLabels.map((label, index) => [label, index + 1]),
  );
  const breastSizeLabels = [
    'Flat',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'R',
    'S',
    'T',
  ];
  const stringList = (value) =>
    Array.isArray(value) ? value : Object.values(value || {});
  const genitalColorActions = {
    genitalia_boobs: ['genitalia_boobs_color', 'genitalia_boobs_color_secondary'],
    genitalia_ass: ['genitalia_ass_color'],
    genitalia_cock: ['genitalia_cock_color'],
    genitalia_testicles: [
      'genitalia_testicles_color',
      'genitalia_testicles_color_secondary',
    ],
    genitalia_vagina: ['genitalia_vagina_color'],
    genitalia_belly: ['genitalia_belly_color'],
  };
  const rowFromData = (id): CharacterCreatorOptionRow => {
    const knownGenitalColors = genitalColorActions[id]?.length;
    return {
      id,
      label: data[`character_creator_${id}_label`],
      value: data[`character_creator_${id}_value`],
      display: data[`character_creator_${id}_display`],
      option_labels: stringList(data[`character_creator_${id}_option_labels`]),
      option_values: stringList(data[`character_creator_${id}_option_values`]),
      size_id: data[`character_creator_${id}_size_id`],
      size_value: data[`character_creator_${id}_size_value`],
      size_kind: data[`character_creator_${id}_size_kind`],
      size_min: data[`character_creator_${id}_size_min`],
      size_max: data[`character_creator_${id}_size_max`],
      color_count:
        knownGenitalColors ?? data[`character_creator_${id}_color_count`] ?? 0,
    };
  };
  const genitalRowIds = stringList(data.character_creator_genital_row_ids);
  const genitalRows: CharacterCreatorOptionRow[] = genitalRowIds.map(rowFromData);
  const partRowIds = stringList(data.character_creator_part_row_ids);
  const partRows: CharacterCreatorOptionRow[] = partRowIds.map(rowFromData);
  const legRows = partRows.filter((row) => row.id === 'digitigrade_legs');
  const featureRows = partRows.filter((row) => row.id !== 'digitigrade_legs');
  const showCombatRobotParts = !!data.allow_mismatched_parts;
  const showSupersoldierParts = !!data.custom_supersoldier_parts;
  const isPrototypeSupersoldier = data.species === 'Prototype Supersoldier';
  const showSyntheticJobBody =
    data.species === 'Synthetic' || data.species === 'Early Synthetic';
  const creatorSizeControl = (row: CharacterCreatorOptionRow) => {
    if (!sizeControls || !row.size_id) {
      return null;
    }
    if (row.size_kind === 'breast') {
      return compactDropdown(
        row.size_value ?? 'C',
        breastSizeLabels,
        row.size_id,
        undefined,
        '64px',
      );
    }
    if (row.size_kind === 'penis_range') {
      const selectedLabel =
        penisSizeLabels[((row.size_value as number) ?? 1) - 1] || '0-10';
      return compactDropdown(
        selectedLabel,
        penisSizeLabels,
        row.size_id,
        penisSizeValues,
        '86px',
      );
    }
    return numberedSizeDropdown(
      row.size_value,
      row.size_id,
      row.size_min ?? 0,
      row.size_max ?? 10,
    );
  };
  const creatorPartColorControls = (row: CharacterCreatorOptionRow) => {
    const colorCount = row.color_count ?? 0;
    if (!colorCount) {
      return null;
    }
    return (
      <Box as="span">
        {Array.from({ length: colorCount }, (_, index) => {
          const colorIndex = index + 1;
          const colorAction =
            data[`character_creator_${row.id}_color_action_${colorIndex}`] ??
            genitalColorActions[row.id]?.[index];
          const label =
            colorIndex === 1
              ? 'Primary'
              : colorIndex === 2
                ? 'Secondary'
                : 'Tertiary';
          const emissiveAction =
            data[`character_creator_${row.id}_emissive_action_${colorIndex}`];
          const emissiveEnabled =
            !!data[`character_creator_${row.id}_emissive_${colorIndex}`];
          return (
            <Box
              key={`${row.id}-color-${colorIndex}`}
              as="span"
              mr={0.25}
              style={{ whiteSpace: 'nowrap' }}
            >
              {colorSwatchButton(
                data[`character_creator_${row.id}_color_${colorIndex}`] ??
                  data[colorAction] ??
                  '#ffffff',
                colorAction,
                `${label} color`,
              )}
              {emissiveAction ? (
                <Button
                  compact
                  color={emissiveEnabled ? 'good' : undefined}
                  disabled={!data.allow_emissives}
                  icon="lightbulb"
                  tooltip={`${label} emissive`}
                  onClick={() =>
                    act(emissiveAction, {
                      field: row.id,
                      color_index: colorIndex,
                    })
                  }
                />
              ) : null}
            </Box>
          );
        })}
      </Box>
    );
  };
  const creatorColorLabel = (row: CharacterCreatorOptionRow) => {
    const genitalLabels = {
      genitalia_boobs: 'Breast Color',
      genitalia_ass: 'Butt Color',
      genitalia_cock: 'Penis Color',
      genitalia_testicles: 'Testicles Color',
      genitalia_vagina: 'Vagina Color',
      genitalia_belly: 'Belly Color',
    };
    return genitalLabels[row.id] ?? `${row.label} Color`;
  };
  const creatorRow = (
    row: CharacterCreatorOptionRow,
    action: string,
    fallbackValue = '',
    sizeContent: any = null,
    colorContent: any = null,
  ) => {
    const currentValue = row.display || fallbackValue;
    const mainRow = (
      <LabeledList.Item key={row.id} label={row.label}>
        <Box
          style={{
            maxWidth: '520px',
            width: '100%',
          }}
        >
          <Box
            style={{
              alignItems: 'center',
              columnGap: '4px',
              display: 'grid',
              gridTemplateColumns: sizeContent
                ? 'minmax(0, 430px) auto'
                : 'minmax(0, 1fr)',
            }}
          >
            <Dropdown
              options={
                row.option_labels?.length ? row.option_labels : [currentValue]
              }
              selected={currentValue}
              displayText={currentValue}
              onSelected={(choice) => {
                const selectedIndex = row.option_labels.indexOf(choice);
                act(action, {
                  field: row.id,
                  value: row.option_values[selectedIndex] ?? fallbackValue,
                });
              }}
            />
            {sizeContent}
          </Box>
        </Box>
      </LabeledList.Item>
    );

    if (!colorContent) {
      return mainRow;
    }

    return [
      mainRow,
      <LabeledList.Item key={`${row.id}-colors`} label={creatorColorLabel(row)}>
        {colorContent}
      </LabeledList.Item>,
    ];
  };
  const creatorGenitalRow = (row: CharacterCreatorOptionRow) =>
    creatorRow(
      row,
      'set_character_creator_value',
      '',
      creatorSizeControl(row),
      creatorPartColorControls(row),
    );
  const creatorPartRow = (row: CharacterCreatorOptionRow) =>
    creatorRow(
      row,
      'set_character_creator_part_value',
      row.display,
      null,
      creatorPartColorControls(row),
    );
  const markingZoneIds = stringList(data.character_creator_marking_zone_ids);
  const markingRow = (zone: string, rowId: string) => {
    const markingName = data[`character_creator_marking_${rowId}_name`];
    const markingChoices = stringList(
      data[`character_creator_marking_${zone}_choices`],
    );
    return (
      <Box
        key={rowId}
        mb={0.5}
        style={{
          alignItems: 'center',
          columnGap: '4px',
          display: 'grid',
          gridTemplateColumns: 'minmax(0, 1fr) auto auto auto',
          maxWidth: '520px',
        }}
      >
        <Dropdown
          options={markingChoices}
          selected={markingName}
          displayText={markingName}
          onSelected={(choice) =>
            act('set_character_creator_marking', {
              zone,
              row_id: rowId,
              marking_name: choice,
            })
          }
        />
        <Button
          compact
          tooltip="Marking color"
          onClick={() =>
            act('color_character_creator_marking', {
              zone,
              row_id: rowId,
            })
          }
        >
          <ColorBox
            color={data[`character_creator_marking_${rowId}_color`] ?? '#ffffff'}
          />
        </Button>
        <Button
          compact
          color={
            data[`character_creator_marking_${rowId}_emissive`]
              ? 'good'
              : undefined
          }
          disabled={!data.allow_emissives}
          icon="lightbulb"
          tooltip="Marking emissive"
          onClick={() =>
            act('toggle_character_creator_marking_emissive', {
              zone,
              row_id: rowId,
            })
          }
        />
        <Button
          compact
          color="bad"
          icon="minus"
          tooltip="Remove marking"
          onClick={() =>
            act('remove_character_creator_marking', {
              zone,
              row_id: rowId,
            })
          }
        />
      </Box>
    );
  };
  const markingZone = (zone: string) => {
    const rowIds = stringList(data[`character_creator_marking_${zone}_row_ids`]);
    const choices = stringList(data[`character_creator_marking_${zone}_choices`]);
    return (
      <LabeledList.Item
        key={zone}
        label={data[`character_creator_marking_${zone}_label`] ?? zone}
      >
        {rowIds.length ? rowIds.map((rowId) => markingRow(zone, rowId)) : null}
        <Button
          compact
          disabled={!choices.length || rowIds.length >= 3}
          icon="plus"
          onClick={() => act('add_character_creator_marking', { zone })}
        >
          Add
        </Button>
      </LabeledList.Item>
    );
  };
  const sizeControls = data.use_genital_size_controls;
  const genders = ['male', 'female', 'plural', 'neuter'];
  const physiques = ['use_gender', 'male', 'female'];
  const genderToName = {
    male: 'Male',
    female: 'Female',
    neuter: 'Object',
    plural: 'Other',
    use_gender: 'Use Gender',
  };
  const nameToGender = Object.fromEntries(
    Object.entries(genderToName).map(([key, value]) => [value, key]),
  );
  const rotatePreview = (action: string) => {
    const now = Date.now();
    if (now - lastPreviewRotate < 120) {
      return;
    }
    setLastPreviewRotate(now);
    act(action);
  };
  const toggleCombatRobotParts = () => {
    const now = Date.now();
    if (now - lastRobotToggle < 200) {
      return;
    }
    setLastRobotToggle(now);
    act('toggle_mismatched_parts');
  };
  const toggleSupersoldierParts = () => {
    const now = Date.now();
    if (now - lastRobotToggle < 200) {
      return;
    }
    setLastRobotToggle(now);
    act('toggle_supersoldier_parts');
  };
  const randomizeName = () => {
    const now = Date.now();
    if (now - lastNameRandomize < 200) {
      return;
    }
    setLastNameRandomize(now);
    act('randomize_name');
  };
  const creatorPanels = {
    identity: 'Identity',
    appearance: 'Appearance',
    species: 'Species',
    features: 'Features',
    markings: 'Markings',
    voice: 'Voice',
  };
  const renderCreatorPanel = () => {
    switch (activeCreatorPanel) {
      case 'identity':
        return (
          <LabeledList>
            <TextFieldPreference
              label={'Full Name'}
              action={'name_real'}
              value={'real_name'}
              extra={
                <Box as="span">
                  <Button onClick={randomizeName}>Randomize</Button>
                  <Button.Checkbox
                    inline
                    content="Always Random"
                    checked={random_name === 1}
                    onClick={() => act('toggle_always_random')}
                  />
                </Box>
              }
            />
            <TextFieldPreference label={'Xenomorph'} value={'xeno_name'} />
            <TextFieldPreference
              label={'Synthetic Name'}
              value={'synthetic_name'}
            />
            <TextFieldPreference label={'AI Name'} value={'ai_name'} />
          </LabeledList>
        );
      case 'appearance':
        return (
          <LabeledList>
              <LabeledList.Item label={'Gender'}>
                <Dropdown
                  options={genders.map((thisgender) => genderToName[thisgender])}
                  selected={genderToName[gender]}
                  displayText={genderToName[gender]}
                  onSelected={(selected) =>
                    act('toggle_gender', { newgender: nameToGender[selected] })
                  }
                />
              </LabeledList.Item>
              <LabeledList.Item label={'Physique'}>
                <Dropdown
                  options={physiques.map(
                    (thisphysique) => genderToName[thisphysique],
                  )}
                  selected={genderToName[physique]}
                  displayText={genderToName[physique]}
                  onSelected={(selected) =>
                    act('toggle_physique', {
                      newphysique: nameToGender[selected],
                    })
                  }
                />
              </LabeledList.Item>
              <SelectFieldPreference
                label={'Hair style'}
                value={'h_style'}
                action={'hairstyle'}
                extra={colorSwatchButton(
                  rgbToHex(r_hair, g_hair, b_hair),
                  'haircolor',
                  'Hair color',
                )}
              />
              <SelectFieldPreference
                label={'Hair gradient style'}
                value={'grad_style'}
                action={'grad_style'}
                extra={colorSwatchButton(
                  rgbToHex(r_grad, g_grad, b_grad),
                  'grad_color',
                  'Gradient color',
                )}
              />
              {colorField(
                'Eye Color',
                rgbToHex(r_eyes, g_eyes, b_eyes),
                'eyecolor',
              )}
              <ToggleFieldPreference
                label={'Eye sight'}
                value={'good_eyesight'}
                leftLabel={'Good'}
                rightLabel={'Bad'}
                action={'toggle_eyesight'}
              />
              <SelectFieldPreference
                label={'Facial hair'}
                value={'f_style'}
                action={'facial_style'}
                extra={colorSwatchButton(
                  rgbToHex(r_facial, g_facial, b_facial),
                  'facialcolor',
                  'Facial hair color',
                )}
              />
            </LabeledList>
        );
      case 'species':
        return (
          <LabeledList>
              <Button.Checkbox
                checked={showCombatRobotParts}
                onClick={toggleCombatRobotParts}
                tooltip="Shows separate body and head controls for custom robot appearances."
              >
                Custom robot parts
              </Button.Checkbox>
              {isPrototypeSupersoldier ? (
                <Button.Checkbox
                  checked={showSupersoldierParts}
                  onClick={toggleSupersoldierParts}
                  tooltip="Shows separate body and head controls for prototype supersoldier appearance."
                >
                  Custom supersoldier parts
                </Button.Checkbox>
              ) : null}
              <SelectFieldPreference
                label={'Species'}
                value={'species'}
                action={'species'}
                extra={colorSwatchButton(
                  data.body_color,
                  'bodycolor',
                  'Body color',
                )}
              />
              {showSyntheticJobBody ? (
                <SelectFieldPreference
                  label={'Synthetic job body'}
                  value={'synthetic_body_base'}
                  action={'synthetic_body_base'}
                  fallback={'Human'}
                  tooltip={'Body base used by the Synthetic and Early Synthetic appearance paths.'}
                />
              ) : null}
              {showCombatRobotParts ? (
                <>
                  <SelectFieldPreference
                    label={'Combat robot body'}
                    value={'robot_body_base'}
                    action={'robot_body_base'}
                    fallback={'Combat Robot'}
                    tooltip={'Body sprite base used by custom robot appearances.'}
                  />
                  <SelectFieldPreference
                    label={'Combat robot head'}
                    value={'robot_head_base'}
                    action={'robot_head_base'}
                    fallback={'Combat Robot'}
                    tooltip={'Head sprite base used by custom robot appearances.'}
                  />
                </>
              ) : null}
              {isPrototypeSupersoldier && showSupersoldierParts ? (
                <>
                  <SelectFieldPreference
                    label={'Supersoldier body'}
                    value={'supersoldier_body_base'}
                    action={'supersoldier_body_base'}
                    fallback={'Human'}
                    tooltip={'Body sprite base used by custom prototype supersoldier appearances.'}
                  />
                  <SelectFieldPreference
                    label={'Supersoldier head'}
                    value={'supersoldier_head_base'}
                    action={'supersoldier_head_base'}
                    fallback={'Human'}
                    tooltip={'Head sprite base used by custom prototype supersoldier appearances.'}
                  />
                </>
              ) : null}
              {legRows.map(creatorPartRow)}
            </LabeledList>
        );
      case 'features':
        return (
          <LabeledList>
            <Button.Checkbox
              checked={data.use_genital_size_controls}
              onClick={() => act('toggle_genital_size_controls')}
            >
              Show size controls
            </Button.Checkbox>
            <Button.Checkbox
              checked={data.allow_emissives}
              onClick={() => act('toggle_emissives')}
            >
              Allow emissives
            </Button.Checkbox>
            {genitalRows.length ? (
              genitalRows.map(creatorGenitalRow)
            ) : (
                <LabeledList.Item label={'Genitals'}>
                  No options available
                </LabeledList.Item>
              )}
              {featureRows.map(creatorPartRow)}
            </LabeledList>
        );
      case 'markings':
        return (
          <LabeledList>
            {markingZoneIds.length ? (
              markingZoneIds.map(markingZone)
            ) : (
              <LabeledList.Item label={'Markings'}>
                No options available
              </LabeledList.Item>
            )}
          </LabeledList>
        );
      case 'voice':
        return (
          <LabeledList>
            <SelectFieldPreference
              label={'Blood Type'}
              value={'blood_type'}
              action={'blood_type'}
            />
            <SelectFieldPreference
              label={'TTS voice'}
              value={'tts_voice'}
              action={'tts_voice'}
            />
            <TextFieldPreference label={'TTS pitch'} value={'tts_pitch'} />
          </LabeledList>
        );
      default:
        return null;
    }
  };
  return (
    <Flex align="stretch">
      <Flex.Item basis="245px" shrink={0} style={{ position: 'relative', zIndex: 0 }}>
        <Section title="Character">
          <Box textAlign="center" mb={1}>
            <Button
              icon="undo"
              fontSize="22px"
              tooltip="Rotate left"
              onClick={() => rotatePreview('preview_rotate_left')}
            />
            <Button
              icon="sync"
              fontSize="22px"
              tooltip="Face front"
              onClick={() => act('preview_face_front')}
            />
            <Button
              icon="redo"
              fontSize="22px"
              tooltip="Rotate right"
              onClick={() => rotatePreview('preview_rotate_right')}
            />
          </Box>
          <Box
            mb={1}
            textAlign="center"
            style={{
              backgroundColor: '#050505',
              border: '1px solid #2b4052',
              height: '260px',
              width: '225px',
              overflow: 'hidden',
            }}
          >
            <ProfilePicture width="225px" height="260px" />
          </Box>
        </Section>
      </Flex.Item>
      <Flex.Item grow={1} basis={0} ml={1} style={{ position: 'relative', zIndex: 2 }}>
        <Section title={creatorPanels[activeCreatorPanel]}>
          <Tabs>
            {Object.entries(creatorPanels).map(([id, label]) => (
              <Tabs.Tab
                key={id}
                selected={activeCreatorPanel === id}
                onClick={() => setActiveCreatorPanel(id)}
              >
                {label}
              </Tabs.Tab>
            ))}
          </Tabs>
          <Box mt={1}>{renderCreatorPanel()}</Box>
        </Section>
      </Flex.Item>
    </Flex>
  );
};
