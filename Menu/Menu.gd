extends Node2D

signal opened_terminal(index)

class Ability:
	var index: int
	var ability_name: String
	var last_used_ms: int
	var ready_when_ms: int
	var can_use: bool


export var player_list: Dictionary
export var terminals_solved: Array = [false, false, false, false]

export var last_hacked = -1
export var last_scanned = -1
export var last_protected = -1

export var time_since_start_ms = 0

var HackAbility = Ability.new()
var ProtectAbility = Ability.new()
var ScanAbility = Ability.new()
var CrackAbility = Ability.new()
var BackdoorAbility = Ability.new()

var player_item_preload = preload("res://Menu/PlayerItem.tscn")


func _on_check_terminal(index):
	emit_signal("opened_terminal", index)


func _ready():
	for i in range(4):
		var term: TouchScreenButton = $Terminals.get_child(i)
		if terminals_solved[i]:
			term.modulate = Color(0, 0.5, 0)
		else:
			term.connect("pressed", self, "_on_check_terminal", [i])

