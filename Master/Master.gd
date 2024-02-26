extends Node


var menu_preload = preload("res://Scenes/Menu/Menu.tscn")
var terminal_preload = preload("res://Scenes/Terminal/Terminal.tscn")
var messages_preload = preload("res://Scenes/Notifications/Messages.tscn")
var info_preload = preload("res://Scenes/Info/Info.tscn")

onready var network_client = get_node("NetworkClient")
onready var login_scene = get_node("Login")
onready var connecting_scene = get_node("Connecting")

func _ready():
	login_scene.start()

func _on_receive_welcome_packet(packet):
	pass
