///How many psy points are gave every 2 seconds by an embryo at low pop
#define EMBRYO_PSY_POINTS_REWARD_MAX 0.48
///How many psy points are gave every 2 seconds by an embyro at high pop
#define EMBRYO_PSY_POINTS_REWARD_MIN 0.16
///How much of the embryo reward is given immediately rather than on birth
#define EMBRYO_REWARD_IMMEDIATE_FRACTION 0.1
///How much of the embryo reward is given on birth rather than immediately
#define EMBRYO_REWARD_DELAYED_FRACTION (1 - EMBRYO_REWARD_IMMEDIATE_FRACTION)
///Multiplier for delayed embryo rewards
#define EMBRYO_REWARD_DELAYED_MULTIPLIER (EMBRYO_REWARD_DELAYED_FRACTION/EMBRYO_REWARD_IMMEDIATE_FRACTION)
///how many ambrosia per supply point from intel
#define INTEL_AMBROSIA_PER_SUPPLY_POINT (1/120)
#define MAX_FACEHUGGERS 8

///extra round type flags
#define MODE_CAMPAIGN_LITE_SUPPORT (1<<0)
///Only disables joining as an observer.
#define MODE_NO_GHOSTS (1<<1)
///makes it not possible to cap the alamo.
#define MODE_NO_ABDUCT (1<<2)
