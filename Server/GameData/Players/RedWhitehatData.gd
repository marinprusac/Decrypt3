extends WhitehatData
class_name RedWhitehatData

func _init(name, reg_cd, exp_cd, hack_duration, forge_duration, protection_duration).(name, "Red Team", exp_cd):
	abilities.append(HackAbilityData.new(exp_cd, hack_duration, forge_duration))
	abilities.append(ProtectAbilityData.new(reg_cd, protection_duration))
	abilities.append(ScanAbilityData.new(reg_cd))

