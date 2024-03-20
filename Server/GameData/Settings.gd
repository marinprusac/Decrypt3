extends Resource
class_name Settings

export var player_codes: Dictionary

# team composition
export var whitehat_percent: float = 0.8
export var blackhat_percent: float = 0.2
export var red_team_percent: float = 0.35
export var blue_team_percent: float = 0.35
export var yellow_team_percent: float = 0.3

# base time unit
export var base_time_unit_seconds: float = 60

# ability cooldowns
export var ability_cooldown_units: float = 12
export var expertise_cooldown_units: float = 4
export var special_cooldown_units: float = 15

# effects duration
export var hacked_duration_units: float = 1.5
export var forged_duration_units: float = 2
export var protection_duration_units: float = 2
export var clearance_duration_units: float = 3

# game duration
export var game_duration_units: float = 60
export var game_duration_increment_units: float = 15

# terminals
export var terminal_count: int = 5
export var ports_per_terminal: int = 3
export var digits_per_port: int = 2
export var blackhat_advantage: int = 1
