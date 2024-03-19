extends Resource
class_name Settings

export var player_codes: Dictionary

# team composition
export var whitehat_ratio: float = 4
export var blackhat_ratio: float = 1
export var red_team_ratio: float = 1
export var blue_team_ratio: float = 1
export var yellow_team_ratio: float = 1

# base time unit
export var base_time_unit_seconds = 60

# ability cooldowns
export var ability_cooldown_ratio: float = 12
export var expertise_cooldown_ratio: float = 4
export var backdoor_cooldown_ratio: float = 15

# effects duration
export var hacked_duration_units: float = 5/4
export var forged_duration_units: float = 3/2
export var protection_duration_units: float = 3/2
export var clearance_duration_units: float = 3

# game duration
export var game_duration_units: float = 60
export var game_duration_increment_units: float = 15

# terminals
export var terminal_count: int = 5
export var ports_per_terminal: int = 3
export var digits_per_port: int = 2
export var blackhat_advantage: int = 1
