type PlayerPreferencesData = {
  slot: number;
  save_slot_names: AssocStringString;
  tabIndex: number;
};

type CharacterCustomizationData = {
  random_name: number;
  gender: string;
  physique: string;
  h_style: string;
  r_hair: number;
  g_hair: number;
  b_hair: number;
  r_grad: number;
  g_grad: number;
  b_grad: number;
  r_facial: number;
  g_facial: number;
  b_facial: number;
  r_eyes: number;
  g_eyes: number;
  b_eyes: number;
  hair_emissive: boolean;
  eye_emissive: boolean;
  tail: string;
  tail_color: string;
  tail_color_secondary: string;
  tail_color_tertiary: string;
  snout: string;
  snout_color: string;
  snout_color_secondary: string;
  snout_color_tertiary: string;
  ears: string;
  ears_color: string;
  ears_color_secondary: string;
  ears_color_tertiary: string;
  horns: string;
  horns_color: string;
  horns_color_secondary: string;
  horns_color_tertiary: string;
  wings: string;
  wings_color: string;
  wings_color_secondary: string;
  wings_color_tertiary: string;
  digitigrade_legs: string;
  body_color: string;
  blood_color: string;
  allow_mismatched_parts: boolean;
  use_genital_size_controls: boolean;
  allow_emissives: boolean;
  species: string;
  synthetic_type: string;
  synthetic_body_base: string;
  robot_body_base: string;
  robot_head_base: string;
  custom_supersoldier_parts: boolean;
  supersoldier_body_base: string;
  supersoldier_head_base: string;
  character_creator_genital_row_ids: string[] | Record<string, string>;
  character_creator_genital_row_count: number;
  character_creator_part_row_ids: string[] | Record<string, string>;
  character_creator_part_row_count: number;
  [key: string]: any;
};

type CharacterCreatorOptionRow = {
  id: string;
  label: string;
  value: string;
  display: string;
  option_labels: string[];
  option_values: string[];
  size_id?: string;
  size_value?: string | number;
  size_kind?: 'breast' | 'number' | 'penis_range';
  size_min?: number;
  size_max?: number;
  color_count?: number;
  emissive_count?: number;
};

type BackgroundInformationData = {
  slot: number;
  age: number;
  citizenship: string;
  religion: string;
  flavor_text: string;
  med_record: string;
  gen_record: string;
  sec_record: string;
  exploit_record: string;
  xeno_desc: string;
  profile_pic: string;
  nsfwprofile_pic: string;
  xenoprofile_pic: string;
};

type FlavorCustomizationData = {
  slot: number;
  xeno_edible_jelly_name: string;
  r_jelly: number;
  g_jelly: number;
  b_jelly: number;
  xeno_edible_jelly_desc: string;
  xeno_edible_jelly_flavors: string;
};

type GameSettingData = {
  ui_style_color: string;
  scaling_method: string;
  pixel_size: number;
  multiz_performance: number;
  parallax: number;
  is_admin: number;
};

type GearCustomizationData = {
  gearsets: PreferencesGearSets;
  gear: string[];
  clothing: PreferencesClothingTypeList;
  underwear: number;
  undershirt: number;
  backpack: number;
  physique_used: string;
};

type KeybindSettingData = {
  all_keybindings: AllKeybindingsList;
  is_admin: number;
};

type KeybindPreferenceData = {
  key_bindings: AssocStringStringArray;
  custom_emotes: AssocStringEmoteArray;
};

type KeybindSentenceCapture = {
  name: string;
};

type ProfilePictureData = {
  mapRef: string;
};

type TextInputModalData = {
  label: string;
  button_text: string;
  onSubmit: Function;
  onBack: Function;
  areaHeigh: string;
  areaWidth: string;
};

type JobPreferencesData = {
  alternate_option: number;
  squads: string[];
  squads_som: string[];
  preferred_squad: string;
  preferred_squad_som: string;
  overflow_job: string[];
  special_occupation: number;
  special_occupations: PreferencesSpecialOccupations;
};

type JobPreferenceData = {
  jobs: PreferencesJobsList;
  job_preferences: AssocStringNumber;
};

type AssocStringNumber = {
  [key: string]: number;
};

type AssocStringEmoteArray = {
  [key: string]: EmoteData;
};

type EmoteData = {
  sentence: string;
  emote_type: string;
};

type KeybindingsData = {
  name: string;
  display_name: string;
  desc: string;
  category: string;
};

type AllKeybindingsList = {
  [key: string]: KeybindingsData[];
};

type PreferencesClothingTypeList = {
  underwear: PreferencesUnderWearTypes;
  undershirt: PreferencesUnderShirtTypes;
  backpack: string[];
};

type PreferencesUnderWearTypes = {
  male: string[];
  female: string[];
};

type PreferencesUnderShirtTypes = {
  male: string[];
  female: string[];
};

type PreferencesSpecialOccupations = {
  [key: string]: {
    flag: number;
    tooltip?: string;
  };
};

type AssocStringString = {
  [key: string]: string;
};

type AssocStringStringArray = {
  [key: string]: string[];
};

type PreferencesGearSets = {
  [key: string]: PreferencesGearDatum;
};
type PreferencesGearDatum = {
  name: string;
  cost: number;
  slot: number;
};

type PreferencesJobsList = {
  [key: string]: PreferencesJobDatum;
};

type PreferencesJobDatum = {
  color: string;
  description: string;
  banned: number;
  playtime_req: number;
  account_age_req: number;
  flags: PreferencesFlagsList;
};

type PreferencesFlagsList = {
  bold: number;
};

type DrawOrder = {
  draw_order: string[];
  quick_equip: string[];
};
