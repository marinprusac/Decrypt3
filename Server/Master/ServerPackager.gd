extends Node

signal ability_used(player_name, target_name, ability_name)
signal crack_used(player_name, terminal_name, port_index, password)
signal backdoor_used(player_name, target_name, team_color)

signal requested_packet_sending(player_name, packet)
signal player_codes_submitted(client_codes)

var game_data: GameData = null

func _on_receive_packet(player_name, packet):
	var packet_type = packet["packet_type"]
	var packet_content = packet["packet_data"]
	
	if packet_type == "ability_used":
		emit_signal("ability_used", player_name, packet_content["target"], packet_content["ability"])
	elif packet_type == "crack_used":
		emit_signal("crack_used", player_name, packet_content["terminal"], packet_content["port"], packet_content["password"])
	elif packet_type == "backdoor_used":
		emit_signal("backdoor_used", player_name, packet_content["target"], packet_content["color"])

func _send_packet_to_client(player_name, packet):
	emit_signal("requested_packet_sending", player_name, packet)

func submit_game_data(game_data: GameData):
	self.game_data = game_data
	emit_signal("player_codes_submitted", game_data.settings.player_codes)
	
func send_welcome_packet(player: PlayerData):
	var packet = {
		"packet_type": "welcome",
		"packet_content": {
			"you": {
				"name": player.name,
				"role": player.role,
				"messages": player.get_messages_array(),
				"abilities": player.get_abilities_dict(),
				"effects": player.get_known_effects(player)
			},
			"players": game_data.get_players_dict(player),
			"terminals": game_data.get_terminals_dict(player)
		}
	}
	_send_packet_to_client(player.name, packet)

func send_start_packet(player):
	var packet = {
		"packet_type": "started",
		"packet_content": {
			"abilities": player.get_abilities_dict(),
			"effects": player.get_known_effects(player)
		}
	}
	_send_packet_to_client(player.name, packet)

func send_pause_packet(player):
	var packet = {
		"packet_type": "paused",
		"packet_content": {}
	}
	_send_packet_to_client(player.name, packet)

func send_end_packet(player, no_winner, victory):
	var packet = {
		"packet_type": "ended",
		"packet_content": {
			"no_winner": no_winner,
			"victory": victory
		}
	}
	_send_packet_to_client(player.name, packet)

func send_abilities_refresh_packet(player):
	var packet = {
		"packet_type": "abilities_refresh",
		"packet_content": player.get_abilities_dict()
	}
	_send_packet_to_client(player.name, packet)

func send_terminals_refresh_packet(player):
	var packet = {
		"packet_type": "terminals_refresh",
		"packet_content": game_data.get_terminals_dict(player)
	}
	_send_packet_to_client(player.name, packet)

func send_effects_refresh_packet(player):
	var packet = {
		"packet_type": "effects_refresh",
		"packet_content": player.get_known_effects(player)
	}
	_send_packet_to_client(player.name, packet)

func send_players_refresh_packet(player):
	var packet = {
		"packet_type": "players_refresh",
		"packet_content": game_data.get_players_dict(player)
	}
	_send_packet_to_client(player.name, packet)

func send_new_message(player, message: MessageData):
	var packet = {
		"packet_type": "new_message",
		"packet_content": message.get_dict()
	}
	_send_packet_to_client(player.name, packet)
