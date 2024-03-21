extends Control


func enter():
	visible = true

func initialize(game_data: GameData):
	$Countdown.initialize(game_data)
	$NuclearSymbol.initialize(game_data)
	$CenterContainer/TerminalProgressionView.initialize(game_data)
	$CenterContainer2/HackerView.initialize(game_data)

func start():
	$NuclearSymbol.start()
	$Countdown.start()

func set_pause(paused: bool):
	$Countdown.set_pause(paused)
	$NuclearSymbol.set_pause(paused)

func handle_changes(game_data: GameData):
	$CenterContainer/TerminalProgressionView.handle_changes(game_data)
	$CenterContainer2/HackerView.handle_changes(game_data)
	$Countdown.handle_changes(game_data)
	$NuclearSymbol.handle_changes(game_data)

func end(winner_exists, whitehat_victory):
	if not winner_exists:
		visible = false
	else:
		$Countdown.end(whitehat_victory)
		$NuclearSymbol.end(whitehat_victory)

