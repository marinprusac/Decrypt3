extends Node

func _ready():
	$ServerMaster/NetworkServer.try_connect()

func server_send(player_name, packet):
	if player_name == "Marin":
		$ClientMaster/NetworkClient._on_receive(packet)

func client_send(packet):
	$ServerMaster/NetworkServer._on_receive("Marin", packet)

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		$ServerMaster/NetworkServer._on_connect()
		$ClientMaster/NetworkClient._on_connect()
		client_send({"packet_type": "joined", "packet_content": {}})
