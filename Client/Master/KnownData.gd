extends Resource
class_name KnownData

var name: String
var role: String
var messages: Array
var abilities: Dictionary
var players: Dictionary
var terminals: Dictionary

enum GameState {PREP, RUNNING, PAUSED, ENDED}
var game_state = null

func _init(welcome_packet):
	name = welcome_packet["name"]
	role = welcome_packet["role"]
	messages = welcome_packet["messages"]
	abilities = welcome_packet["abilities"]
	players = welcome_packet["players"]
	terminals = welcome_packet["terminals"]
	game_state = GameState.PREP
