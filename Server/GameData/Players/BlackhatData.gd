extends PlayerData
class_name BlackhatData

func _init(name, exp_cd, spc_cd, clearance_duration, hack_duration, forge_duration, protection_duration).(name, "Blackhat"):
	abilities.append(BackdoorAbilityData.new(spc_cd, clearance_duration))
	abilities.append(SabotageAbilityData.new(exp_cd))
	abilities.append(HackAbilityData.new(exp_cd, hack_duration, forge_duration))
	abilities.append(ProtectAbilityData.new(exp_cd, protection_duration))
	abilities.append(ScanAbilityData.new(exp_cd))
