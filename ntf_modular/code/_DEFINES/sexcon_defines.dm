///when received any sex action start
#define COMSIG_STARTED_SEX_UPON "comsig_started_sex"
///when came into someone
#define COMSIG_CAME_INTO "comsig_came_into"
///when made to cum into someone
#define COMSIG_CAME_INTO_BY "comsig_came_into_by"
///when came onto someone
#define COMSIG_CAME_ONTO "comsig_came_onto"
///when made to cum onto someone
#define COMSIG_CAME_ONTO_BY "comsig_came_onto_by"
///every time we receive sex action
#define COMSIG_RECEIVED_SEX "comsig_received_sex"

GLOBAL_LIST_INIT(sex_actions, build_sex_actions())

/// Returns whether a type is an abstract type.
/proc/is_abstract(datum/datumussy)
	var/datum/sex_action/datum_type = datumussy
	return (initial(datum_type.abstract_type) == datum_type)

/proc/build_sex_actions()
	. = list()
	for(var/path in typesof(/datum/sex_action))
		if(is_abstract(path))
			continue
		.[path] = new path()
	return .
