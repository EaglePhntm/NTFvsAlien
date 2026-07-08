/datum/opportunity/planetside/subterranexcavationscan
	name = "Subterran excavation scan"
	desc = "Align our scanners for a detailed subterran scan based on possible locations for an xenoarcheology mission sites derived from intel."
	proper = TRUE
	cost = 100
	announcefac = "After a brief recalibration of our sensors using intel found planetside, we have detected a possible digsite. Please proceed planetside."
	announcehumanoid = "A Sudden scan pulse has been identified as a subterran scan. After analyzing the scan configuration, we were able to replicate it, and have appended our maps with the new data."
	announcexenos = "Suddenly, a chorus of pulses washes through our body, and sink into the ground. The talls are looking for something underground... something that rightfully belongs to us... an artifact... we should make sure it does not get stolen..."

/datum/opportunity/planetside/subterranexcavationscan/eligible(mob/m)
	if(!HAS_TRAIT(m,TRAIT_RESEARCHER))
		return FALSE
	var/essl = length(SSexcavation.excavation_site_spawners)
	if(essl <= 0)
		return FALSE
	if(SSexcavation.excavations_count >= 5)
		return FALSE


/datum/opportunity/planetside/subterranexcavationscan/activate(mob/m)
	SSexcavation.spawnExcavation()
