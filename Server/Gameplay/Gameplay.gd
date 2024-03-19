extends Control

var game_data: GameData

func initialize(game_data: GameData):
	self.game_data = game_data
	$CenterContainer/TerminalProgressionView.initialize(game_data.terminals)
	$CenterContainer2/HackerView.initialize(game_data.players)

func start():
	game_data.start_game()
	$NuclearSymbol.start()
	$Countdown.start(game_data.game_end)

func refresh():
	$CenterContainer/TerminalProgressionView.refresh(game_data.terminals)
	$CenterContainer2/HackerView.refresh(game_data.players)
	$Countdown.refresh(game_data.game_end)
	$NuclearSymbol.refresh(game_data)

func end(victory):
	$Countdown.end(victory)
	$NuclearSymbol.end(victory)
