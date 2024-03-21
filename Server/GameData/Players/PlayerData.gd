extends Resource
class_name PlayerData

var name: String
var role: String

var known_ports: Array = []

var abilities: Array = []
var effects: Array = []
var messages: Array = []

func _init(name: String, role: String):
	self.name = name
	self.role = role

func get_ability(ability_name):
	for ability in abilities:
		if ability.name == ability_name:
			return ability as AbilityData
	return null

func add_effect(effect: EffectData):
	effects.append(effect)

func get_effect(effect_name):
	for effect in effects:
		if effect.name == effect_name:
			if not effect.permanent and Time.get_unix_time_from_system() >= effect.end:
				effects.erase(effect)
			else:
				return effect
	return null

func has_effect(effect_name):
	return get_effect(effect_name) != null

func remove_effect(effect_name):
	effects.erase(get_effect(effect_name))

func get_message(message_name):
	for message in messages:
		if message.name == message_name:
			return message
	return null
	
func are_allies(player: PlayerData):
	return role == "Blackhat" and player.role == "Blackhat" or self == player

func get_usable_abilities(player: PlayerData):
	var usable = []
	if player == self:
		return []
	if player.get_ability("Hack").last_target != name:
		usable.append("Hack")
	if player.get_ability("Protect").last_target != name:
		usable.append("Protect")
	if player.get_ability("Scan").last_target != name:
		usable.append("Scan")
	if player.role == "Blackhat" and player.get_ability("Backdoor").last_target != name:
		usable.append("Backdoor")
	return usable

func get_known_effects(player: PlayerData):
	var effects = []
	if player == self:
		return []
	if player.role == "Blackhat":
		if has_effect("Backdoored"):
			effects.append("Backdoored")
		if has_effect("Clearance"):
			effects.append("Clearance")
	return effects

func get_dict(player: PlayerData):
	return {
		"ally": are_allies(player),
		"effects": get_known_effects(player),
		"usable_abilities": get_usable_abilities(player)
	}

func get_messages_array():
	var array = []
	for message in messages:
		array.append(message.get_dict())

func get_abilities_dict():
	var dict = {}
	for ability in abilities:
		dict[ability.name] = ability.to_dict()
	return dict
