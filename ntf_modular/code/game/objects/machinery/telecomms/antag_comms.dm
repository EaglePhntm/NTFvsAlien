//i give up, this dont work, except clf for some fucking reason

//CM/ICC
/obj/machinery/telecomms/bus/preset_four/cm
	id = "Bus cm"
	freq_listening = list(FREQ_ICC)
	autolinkers = list("processor4_cm", "common_cm")

/obj/machinery/telecomms/processor/preset_four/cm
	id = "Processor cm 4"
	autolinkers = list("processor4_cm")

/obj/machinery/telecomms/server/presets/common/cm
	id = "Common Server CM"
	freq_listening = list(FREQ_ICC)
	autolinkers = list("common_cm")

/obj/machinery/telecomms/hub/preset/cm
	id = "Hub CM"
	autolinkers = list("hub_cm", "relay", "s_relay", "common_cm",
	"receiverA_cm", "receiverB_cm", "broadcasterA_cm")

/obj/machinery/telecomms/receiver/preset_right/cm
	id = "Receiver B cm"
	autolinkers = list("receiverB_cm") // link to relay
	freq_listening = list(FREQ_ICC)

/obj/machinery/telecomms/broadcaster/preset_left/cm
	id = "Broadcaster A cm"
	network = "tcommsat"
	autolinkers = list("broadcasterA_cm")

/obj/machinery/telecomms/allinone/cm
	freq_listening = list(FREQ_ICC)


//KZ

/obj/machinery/telecomms/bus/preset_four/kz
	id = "Bus kz"
	freq_listening = list(FREQ_VSD)
	autolinkers = list("processor4_kz", "common_kz")

/obj/machinery/telecomms/processor/preset_four/kz
	id = "Processor kz 4"
	autolinkers = list("processor4_kz")

/obj/machinery/telecomms/server/presets/common/kz
	id = "Common Server KZ"
	freq_listening = list(FREQ_VSD)
	autolinkers = list("common_kz")

/obj/machinery/telecomms/hub/preset/kz
	id = "Hub KZ"
	autolinkers = list("hub_kz", "relay", "s_relay", "common_kz",
	"receiverA_kz", "receiverB_kz", "broadcasterA_kz")

/obj/machinery/telecomms/receiver/preset_right/kz
	id = "Receiver B kz"
	autolinkers = list("receiverB_kz") // link to relay
	freq_listening = list(FREQ_VSD)

/obj/machinery/telecomms/broadcaster/preset_left/kz
	id = "Broadcaster A kz"
	network = "tcommsat"
	autolinkers = list("broadcasterA_kz")

/obj/machinery/telecomms/allinone/kz
	freq_listening = list(FREQ_VSD)

//CLF

/obj/machinery/telecomms/bus/preset_four/clf
	id = "Bus clf"
	freq_listening = list(FREQ_COLONIST)
	autolinkers = list("processor4_clf", "common_clf")

/obj/machinery/telecomms/processor/preset_four/clf
	id = "Processor clf 4"
	autolinkers = list("processor4_clf")

/obj/machinery/telecomms/server/presets/common/clf
	id = "Common Server CLF"
	freq_listening = list(FREQ_COLONIST)
	autolinkers = list("common_clf")

/obj/machinery/telecomms/hub/preset/clf
	id = "Hub CLF"
	autolinkers = list("hub_clf", "relay", "s_relay", "common_clf",
	"receiverA_clf", "receiverB_clf", "broadcasterA_clf")

/obj/machinery/telecomms/receiver/preset_right/clf
	id = "Receiver B clf"
	autolinkers = list("receiverB_clf") // link to relay
	freq_listening = list(FREQ_COLONIST)

/obj/machinery/telecomms/broadcaster/preset_left/clf
	id = "Broadcaster A clf"
	network = "tcommsat"
	autolinkers = list("broadcasterA_clf")

/obj/machinery/telecomms/allinone/clf
	freq_listening = list(FREQ_COLONIST)

//PMC

/obj/machinery/telecomms/bus/preset_four/pmc
	id = "Bus pmc"
	freq_listening = list(FREQ_PMC)
	autolinkers = list("processor4_pmc", "common_pmc")

/obj/machinery/telecomms/processor/preset_four/pmc
	id = "Processor pmc 4"
	autolinkers = list("processor4_pmc")

/obj/machinery/telecomms/server/presets/common/pmc
	id = "Common Server PMC"
	freq_listening = list(FREQ_PMC)
	autolinkers = list("common_pmc")

/obj/machinery/telecomms/hub/preset/pmc
	id = "Hub PMC"
	autolinkers = list("hub_pmc", "relay", "s_relay", "common_pmc",
	"receiverA_pmc", "receiverB_pmc", "broadcasterA_pmc")

/obj/machinery/telecomms/receiver/preset_right/pmc
	id = "Receiver B pmc"
	autolinkers = list("receiverB_pmc") // link to relay
	freq_listening = list(FREQ_PMC)

/obj/machinery/telecomms/broadcaster/preset_left/pmc
	id = "Broadcaster A pmc"
	network = "tcommsat"
	autolinkers = list("broadcasterA_pmc")

/obj/machinery/telecomms/allinone/pmc
	freq_listening = list(FREQ_PMC)
