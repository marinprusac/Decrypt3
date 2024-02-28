extends Node


onready var network_client = get_node("NetworkClient")
onready var login_scene = get_node("Login")
onready var connecting_scene = get_node("Connecting")
onready var terminals = get_node("Terminals")

var menu_scene = null
var messages_scene = null
var info_scene = null

func _ready():
	login_scene.start()
	


