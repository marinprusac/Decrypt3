extends Node

signal player_joined(player)

signal hack_used(player, target)
signal protect_used(player, target)
signal scan_used(player, target, team_color)
signal crack_used(terminal, port, password)
signal sabotage_used(terminal, port, password)
signal backdoor_used(player, target, team_color)

signal requested_packet_sending(packet)

var game_data: GameData = null

func submit_game_data(game_data: GameData):
	self.game_data = game_data
	emit_signal("requested_packet_sending", {"packet_type": "player_codes", "packet_content": game_data.settings.player_codes})

func _on_receive_packet(packet):
	var packet_type = packet["packet_type"]
	var packet_content = packet["packet_content"]
	var player_name = packet["player"]
	
	var player = game_data.get_player(player_name)
	if packet_type == "joined":
		emit_signal("player_joined", player)
	
	if packet_type == "hack_used":
		var target = game_data.get_player(packet_content["target"])
		emit_signal("hack_used", player, target)
		
	if packet_type == "protect_used":
		var target = game_data.get_player(packet_content["target"])
		emit_signal("protect_used", player, target)
		
	if packet_type == "scan_used":
		var target = game_data.get_player(packet_content["target"])
		var color = packet_content["color"]
		emit_signal("scan_used", player, target, color)
		
	elif packet_type == "crack_used":
		var terminal = game_data.get_terminal(packet_content["terminal"])
		var port = terminal.ports[packet_content["port"]]
		var password = packet_content["password"]
		emit_signal("crack_used", player, terminal, port, password)

	elif packet_type == "sabotage_used":
		var terminal = game_data.get_terminal(packet_content["terminal"])
		var port = terminal.ports[packet_content["port"]]
		var password = packet_content["password"]
		emit_signal("sabotage_used", player, terminal, port, password)
		
	elif packet_type == "backdoor_used":
		var target = game_data.get_player(packet_content["target"])
		var color = packet_content["color"]
		emit_signal("backdoor_used", player, target, color)

func _send_packet_to_client(player, packet):
	packet["player"] = player.name
	emit_signal("requested_packet_sending", packet)
	
func send_welcome_packet(player: PlayerData):
	var packet = {
		"packet_type": "welcome",
		"packet_content": {
			"name": player.name,
			"role": player.role,
			"players": game_data.get_players_dict(player),
			"abilities": player.get_abilities_dict(game_data.players, game_data.terminals),
			"messages": player.get_messages_array(),
			"terminals": game_data.get_terminals_dict(player)
		}
	}
	_send_packet_to_client(player, packet)

func send_start_to_single(player):
	var packet = {
		"packet_type": "started",
		"packet_content": {
		}
	}
	_send_packet_to_client(player, packet)

func send_start_packet():
	for player in game_data.players:
		send_start_to_single(player)

func send_pause_packet(player, time_elapsed = null):
	var packet = {
		"packet_type": "paused",
		"packet_content": {
			"time_elapsed": time_elapsed
		}
	}
	_send_packet_to_client(player, packet)

func send_end_packet(player, no_winner, victory):
	var packet = {
		"packet_type": "ended",
		"packet_content": {
			"no_winner": no_winner,
			"victory": victory
		}
	}
	_send_packet_to_client(player, packet)

func send_abilities_refresh_packet(player):
	var packet = {
		"packet_type": "abilities_refresh",
		"packet_content": player.get_abilities_dict(game_data.players, game_data.terminals)
	}
	_send_packet_to_client(player, packet)

func send_terminals_refresh_packet(player):
	var packet = {
		"packet_type": "terminals_refresh",
		"packet_content": game_data.get_terminals_dict(player)
	}
	_send_packet_to_client(player, packet)

func send_new_message_packet(player, message):
	var packet = {
		"packet_type": "new_message",
		"packet_content": message.get_dict()
	}
	_send_packet_to_client(player, packet)
