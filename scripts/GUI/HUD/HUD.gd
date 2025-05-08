extends Control

@export var player: Player

@onready var health_GUI: HealthGUI = $HealthGUI
@onready var block_gui: AbilityGUI = $BlockGUI
@onready var energy_ability_gui: EnergyAbilityGUI = $EnergyAbilityGUI

func _ready() -> void:
	health_GUI.set_health(player.health)
	block_gui.set_ability(player.player_block_action)
	energy_ability_gui.set_energy_ability(player.player_dash_action)
