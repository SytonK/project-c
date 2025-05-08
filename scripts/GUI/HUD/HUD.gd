extends Control

@export var player: Player

@onready var health_GUI: HealthGUI = $HealthGUI
@onready var block_gui: AbilityGUI = $BlockGUI

func _ready() -> void:
	health_GUI.set_health(player.health)
	block_gui.set_ability(player.player_block_action)
