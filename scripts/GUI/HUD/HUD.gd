extends Control

@export var player: Player

@onready var health_GUI: HealthGUI = $HealthGUI
@onready var block_gui: AbilityGUI = $BlockGUI
@onready var energy_ability_gui: EnergyAbilityGUI = $EnergyAbilityGUI
@onready var weapon_energy_bar: WeaponEnergyBar = $WeaponEnergyBar
@onready var weapon_energy_bar_2: WeaponEnergyBar = $WeaponEnergyBar2

func _ready() -> void:
	health_GUI.set_health(player.health)
	block_gui.set_ability(player.player_block_action)
	energy_ability_gui.set_energy_ability(player.player_dash_action)

func set_weapons() -> void:
	if player.weapon_manager.weapons.size() >= 1:
		weapon_energy_bar.weapon = player.weapon_manager.weapons[0]
	if player.weapon_manager.weapons.size() >= 2:
		weapon_energy_bar_2.weapon = player.weapon_manager.weapons[1]
