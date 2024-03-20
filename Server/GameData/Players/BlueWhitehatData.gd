extends WhitehatData
class_name BlueWhitehatData

func _init(name, reg_cd, exp_cd, hack_duration, forge_duration, protection_duration).(name, "Blue Team", exp_cd):
	abilities.append(HackAbilityData.new(reg_cd, hack_duration, forge_duration))
	abilities.append(ProtectAbilityData.new(exp_cd, protection_duration))
	abilities.append(ScanAbilityData.new(reg_cd))

