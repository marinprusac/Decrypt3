extends Node

signal initialized(game_data)
signal started()
signal started_single(player)
signal pause_set(paused)
signal ended(winner_exists, whitehat_victory)
signal changed(game_data)

signal send_welcome(player)

signal send_started(player)
signal send_paused(player, paused)
signal send_ended(player, no_winner, victory)

signal send_abilities_refresh(player)
signal send_terminals_refresh(player)
signal send_new_message(player, message)

var settings: Settings
var game_data: GameData
var running = false
var game_over = false
var time_paused = null

func initialize(settings: Settings):
	self.settings = settings
	self.game_data = GameData.new(settings)
	emit_signal("initialized", game_data)

func start():
	if running or game_over:
		return
	running = true
	game_data.start_game()
	
	for player in game_data.players:
		emit_signal("send_welcome", player)
	
	emit_signal("started")

func set_pause(paused: bool):
	var time_passed_paused = null
	if paused != (time_paused == null):
		return
	if paused:
		time_paused = Time.get_unix_time_from_system()
	else:
		Time.get_unix_time_from_system() - time_paused
		game_data.game_end = time_passed_paused + game_data.game_end
		_on_change()
		time_paused = null
	emit_signal("pause_set", paused, time_passed_paused)
		
func end(winner_exists, whitehat_victory):
	if not running:
		return
	running = false
	game_over = true
	emit_signal("ended", winner_exists, whitehat_victory)

func _send_msg(player: PlayerData, message: MessageData):
	player.messages.append(message)
	emit_signal("send_new_message", player, message)
	
func _send_abilities_refresh(player: PlayerData):
	emit_signal("send_abilities_refresh", player)

func _send_terminals_refresh(player):
	emit_signal("send_terminals_refresh", player)

func _on_change():
	emit_signal("changed", game_data)

func _on_player_joined(player):
	if running:
		emit_signal("send_welcome", player)
		emit_signal("started_single", player)

func _on_hack_used(player: PlayerData, target: PlayerData):
	var hack: HackAbilityData = player.get_ability("Hack")
	if not hack.can_use(player, target):
		print(player.name)
		print(target.name)
		print(hack.is_on_cooldown())
		print(hack.is_valid_target(player, target))
		print(hack.can_use(player, target))
		_send_abilities_refresh(player)
		return
		
	hack.last_target = target
	hack.start_cooldown()
	
	if target.has_effect("Protected"):
		_send_msg(player, MessageData.new("Hack Failed", target.name + " was protected from your hack.", "hack"))
	else:
		if target.has_effect("Forged"):
			target.get_effect("Forged").end += hack.forge_duration
		else:
			target.effects.append(ForgedEffectData.new(hack.forge_duration))
		
		for ability in target.abilities:
			if not ability.is_on_cooldown():
				ability.start_cd = Time.get_unix_time_from_system()
				ability.end_cd = ability.start_cd + hack.hack_duration
			else:
				ability.end_cd += hack.hack_duration
		_send_msg(player, MessageData.new("Hack Successful", target.name + " was hacked successfully.", "hack"))
		_send_msg(target, MessageData.new("YOU'RE HACKED", "Someone has hacked you. Your abilities are shortly disabled and you might seem suspicious.", "hack"))
		_send_abilities_refresh(target)
	
	_send_abilities_refresh(player)
	_on_change()

func _on_protect_used(player: PlayerData, target: PlayerData):
	var protect = player.get_ability("Protect")
	if not protect.can_use(player, target):
		return
	
	protect.last_target = target
	protect.start_cooldown()
	
	if target.has_effect("Protected"):
		target.get_effect("Protected").end += protect.protection_duration
	else:
		target.effects.append(ProtectedEffectData.new(protect.protection_duration))
	
	_send_abilities_refresh(player)
	_send_msg(player, MessageData.new("Protect Successful", "You successfully protected " + target.name + ".", "protect"))
	_on_change()

func _on_scan_used(player: PlayerData, target: PlayerData, team_color: String):
	var scan = player.get_ability("Scan")
	if not scan.can_use(player, target):
		return
	
	scan.last_target = target
	scan.start_cooldown()
	
	var result = "no"
	if target.has_effect("Clearance") and target.get_effect("Clearance").color == team_color:
		result = "yes"
	if target.is_team(team_color):
		result = "yes"
	if target.has_effect("Hacked"):
		result = "no"
	if target.has_effect("Protected"):
		result = "protected"
	
	if result == "protected":
		_send_msg(player, MessageData.new("Scan Failed", target.name + " was protected from your scan.", "scan"))
	elif result == "yes":
		_send_msg(player, MessageData.new("Scan Successful", "Scan concluded that " + target.name + " DOES belong to the " + team_color + " team.", "scan"))
	elif result == "no":
		_send_msg(player, MessageData.new("Scan Successful", "Scan concluded that " + target.name + " DOESN'T belong to the " + team_color + " team.", "scan"))

	_send_abilities_refresh(player)
	_on_change()

func _on_backdoor_used(player: PlayerData, target: PlayerData, team_color: String):
	var backdoor = player.get_ability("Backdoor")
	if not backdoor.can_use(player, target):
		return null
		
	backdoor.last_target = target
	backdoor.start_cooldown()
	
	if target.role != "Blackhat":
		if target.has_effect("Protected"):
			_send_msg(player, MessageData.new("Backdoor Failed", target.name + " was protected from your attack.", "backdoor"))
		else:
			if not target.is_team(team_color):
				_send_msg(player, MessageData.new("Backdoor Failed", target.name + " doesn't belong to the " + team_color + " team.", "backdoor"))
			else:
				for ability in target.abilities:
					ability.cooldown *= 1.2
				for ability in player.abilities:
					ability.cooldown *= 0.9
				target.add_effect(BackdooredEffectData.new())
				_send_msg(player, MessageData.new("Backdoor Successful", target.name + " was successfully backdoored as a " + team_color + " team member.", "backdoor"))
				_send_msg(target,  MessageData.new("YOU'RE BACKDOORED", "Someone discovered what team you belong to and successfully backdoored you. Your abilities now take longer to reload.", "backdoor"))
	else:
		target.remove_effect("Clearance")
		target.add_effect(ClearanceEffectData.new(backdoor.effect_duration, team_color))
		_send_msg(player, MessageData.new("Clearance Successful", target.name + " successfully gained a temporary "+ team_color +" team clearance.", "backdoor"))
		_send_msg(target, MessageData.new("YOU'RE CLEARANCED", player.name + " has granted you a temporary "+ team_color +" team clearance.", "backdoor"))
	
	_send_abilities_refresh(player)
	_on_change()

func _on_crack_used(player: PlayerData, terminal: TerminalData, port: PortData, password: String):
	var crack: CrackAbilityData = player.get_ability("Crack")
	if not crack.can_use(player, terminal, port):
		return
	
	crack.last_target = terminal
	crack.start_cooldown()
	
	if password == port.password:
		player.known_ports.append(port.name)
		port.solved = true
		_send_msg(player, MessageData.new("Crack Result", "Your guess of " + password + " was correct. Port is cracked.", "password"))
		_send_terminals_refresh(player)
		var all_there = true
		for port in terminal.ports:
			if not port.name in player.known_ports:
				all_there = false
				break
		if all_there:
			terminal.solved = true
			for p in game_data.players:
				_send_msg(p, MessageData.new("TERMINAL "+ terminal.name +" DECRYPTED", "All ports of terminal "+ terminal.name +" have been cracked. The terminal is now decrypted.", "password"))
				_send_terminals_refresh(p)
	elif password > port.password:
		_send_msg(player, MessageData.new("Crack Result", "Your guess of %s for port %s (terminal %s) was wrong. Real port password is lower." % [password, port.name, terminal.name], "password"))
	elif password < port.password:
		_send_msg(player, MessageData.new("Crack Result", "Your guess of %s for port %s (terminal %s) was wrong. Real port password is higher." % [password, port.name, terminal.name], "password"))

	_send_abilities_refresh(player)
	_on_change()

func _on_sabotage_used(player: PlayerData, terminal: TerminalData, port: PortData, password: String):
	var sabotage = player.get_ability("Sabotage")
	if not sabotage.can_use(player, terminal, port):
		return
	
	sabotage.last_target = terminal
	sabotage.start_cooldown()
	
	if password == port.password:
		for p in game_data.players:
			if p.role == "Blackhat":
				p.known_ports.append(port.name)
				_send_msg(player, MessageData.new("Port Sabotaged", "Terminal %s's port %s has been successfully sabotaged with password %s." % [terminal.name, port.name, password], "password"))
				_send_terminals_refresh(p)
		var all_there = true
		for port in terminal.ports:
			if not port.name in player.known_ports:
				all_there = false
				break
		if all_there:
			game_data.encrypt_terminal(terminal)
			for p in game_data.players:
				_send_terminals_refresh(p)
	elif password > port.password:
		_send_msg(player, MessageData.new("Sabotage Result", "Your guess of %s for port %s (terminal %s) was wrong. Real port password is lower." % [password, port.name, terminal.name], "password"))
	else:
		_send_msg(player, MessageData.new("Sabotage Result", "Your guess of %s for port %s (terminal %s) was wrong. Real port password is higher." % [password, port.name, terminal.name], "password"))

	_send_abilities_refresh(player)
	_on_change()

func _process(delta):
	if not running:
		return

	if game_data.is_game_over():
		end(true, Time.get_unix_time_from_system() < game_data.game_end)

