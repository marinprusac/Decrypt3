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
			return ability
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

func get_messages_array():
	var array = []
	for message in messages:
		array.append(message.get_dict())

func get_abilities_dict(players, terminals):
	var dict = {}
	for ability in abilities:
		if ability is TerminalTargetedAbilityData:
			dict[ability.name] = ability.to_dict(self, terminals)
		if ability is PlayerTargetedAbilityData:
			dict[ability.name] = ability.to_dict(self, players)
	return dict
