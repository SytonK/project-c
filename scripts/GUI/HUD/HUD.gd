extends Control

@export var player: Player

@onready var health: HealthGUI = $Health

func _ready() -> void:
	_init_health()

func _init_health() -> void:
	health.set_max_health(int(player.health.max_value))
	player.health.value_changed.connect(health._set_health)
