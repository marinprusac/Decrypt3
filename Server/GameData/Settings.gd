extends Resource
class_name Settings

export var player_codes: Dictionary

# team composition
export var whitehat_ratio: float = 4
export var blackhat_ratio: float = 1
export var red_team_ratio: float = 1
export var blue_team_ratio: float = 1
export var yellow_team_ratio: float = 1

# ability properties
export var regular_cooldown_mins: float = 12
export var expertise_cooldown_mins: float = 4

# terminals
export var terminal_count: int = 3
export var ports_per_terminal: int = 3
export var digits_per_port: int = 2
export var blackhat_advantage: int = 1

# game duration
export var initial_game_duration_mins: float = 60
export var game_duration_increment_mins: float = 15


