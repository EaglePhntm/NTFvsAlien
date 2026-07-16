/datum/opportunity/planetside/advmining
	name = "Subterran mineral scan"
	desc = "Align our scanners for a detailed mineral scan based on possible locations for resource deposit mission sites derived from intel. The scanner arrays will function at the default configuration, which, while will yield an unpredictable result, will also be cheaper."
	proper = TRUE
	cost = 500
	firstmovers = 5 MINUTES
	announcefac = "After a brief recalibration of our sensors using intel found planetside, we have detected a possible mineral extraction site. Please proceed planetside."
	announcehumanoid = "A Sudden scan pulse has been identified as a mineral scan. After analyzing the scan configuration, we were able to replicate it, and have appended our maps with the new data."
	announcexenos = "Suddenly, a chorus of pulses washes through our body, and sink into the ground. The talls are looking for something underground... something that rightfully belongs to us... a mining site... we should make sure it does not get exploited..."

/datum/opportunity/planetside/advmining/eligible(mob/m)
	var/essl = length(SSescalation.miningsites)
	if(essl <= 0)
		return FALSE
	if(SSescalation.activedeposits.len >= 5)
		return FALSE

/datum/opportunity/planetside/advmining/activate(mob/m)
	SSexcavation.spawnExcavation()
	for(var/obj/effect/landmark/miningsite/ms in shuffle(SSescalation.miningsites))
		if(!ms.activedeposit)
			ms.createDeposit(parent)
			return TRUE
	return FALSE



/datum/opportunity/planetside/advmining/deep
	name = "Deep Subterran mineral scan"
	desc = "Align our scanners for a detailed mineral scan based on possible locations for resource deposit mission sites derived from intel. The scanner arrays will be further calibrated for underground deposits, costing more but with a bigger possible payout."
	cost = 1000

/datum/opportunity/planetside/advmining/deep/activate(mob/m)
	SSexcavation.spawnExcavation()
	for(var/obj/effect/landmark/miningsite/ms in shuffle(SSescalation.miningsites))
		if(!ms.activedeposit && ms.deep)
			ms.createDeposit(parent)
			return TRUE
	return FALSE


/datum/opportunity/planetside/advmining/surface
	name = "Surface Subterran mineral scan"
	desc = "Align our scanners for a detailed mineral scan based on possible locations for resource deposit mission sites derived from intel. The scanner arrays will be further calibrated for surface deposits, costing more but will find spots that should be easier to defend."
	cost = 750

/datum/opportunity/planetside/advmining/surface/activate(mob/m)
	SSexcavation.spawnExcavation()
	for(var/obj/effect/landmark/miningsite/ms in shuffle(SSescalation.miningsites))
		if(!ms.activedeposit && (!ms.deep))
			ms.createDeposit(parent)
			return TRUE
	return FALSE
