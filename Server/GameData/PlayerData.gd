extends Resource
class_name PlayerData

var settings: Settings

var name: String = ""
var role: String = ""

var abilities = []
var effects = []
var messages = []

func _init(name: String, role: String, settings: Settings):
	self.name = name
	self.role = role
	
	var hack_cd = settings.regular_cooldown_mins
	var protect_cd = settings.regular_cooldown_mins
	var scan_cd = settings.regular_cooldown_mins
	
	if role == "Red Team Whitehat":
		hack_cd = settings.expertise_cooldown_mins
	if role == "Blue Team Whitehat":
		protect_cd = settings.expertise_cooldown_mins
	if role == "Yellow Team Whitehat":
		scan_cd = settings.expertise_cooldown_mins
	if role == "Blackhat":
		hack_cd = settings.expertise_cooldown_mins
		protect_cd = settings.expertise_cooldown_mins
		scan_cd = settings.expertise_cooldown_mins
		abilities.append(AbilityData.new("Backdoor", settings.regular_cooldown_mins))

	abilities.append(AbilityData.new("Hack", hack_cd))
	abilities.append(AbilityData.new("Protect", protect_cd))
	abilities.append(AbilityData.new("Scan", scan_cd))
	abilities.append(AbilityData.new("Crack", settings.expertise_cooldown_mins))

#func add_ability(ability: AbilityData):
#	abilities.append(ability)
#
#func get_ability(ability_name):
#	for ability in abilities:
#		if ability.name == ability_name:
#			return ability
#	return ERR_INVALID_PARAMETER
#
#func add_effect(effect: EffectData):
#	effects.append(effect)
#
#func get_effect(effect_name):
#	for effect in effects:
#		if effect.name == effect_name:
#			return effect
#	return ERR_INVALID_PARAMETER
#
#func add_message(message: MessageData):
#	messages.append(message)
#
#func get_message(message_name):
#	for message in messages:
#		if message.name == message_name:
#			return message
#	return ERR_INVALID_PARAMETER
	
