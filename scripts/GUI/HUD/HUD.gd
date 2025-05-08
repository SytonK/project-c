extends Control

@export var player: Player

@onready var health_GUI: HealthGUI = $HealthGUI

func _ready() -> void:
	health_GUI.set_health(player.health)
