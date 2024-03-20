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

func handle_changes(game_data: GameData):
	$CenterContainer/TerminalProgressionView.handle_changes(game_data)
	$CenterContainer2/HackerView.handle_changes(game_data)
	$Countdown.handle_changes(game_data)
	$NuclearSymbol.handle_changes(game_data)

func end(victory):
	$Countdown.end(victory)
	$NuclearSymbol.end(victory)
