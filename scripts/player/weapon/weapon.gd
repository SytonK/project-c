class_name Weapon extends Node2D

enum AttackType {LIGHT, HEAVY, SPECIAL}

var player: Player

var weapon_energy: WeaponEnergy = WeaponEnergy.new()

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func attack(attack_type: AttackType) -> void:
	var type_str: String = AttackType.keys()[attack_type].to_lower()
	var direction_str: String = PlayerInput.InputDirection.keys()[PlayerInput.get_input_direction()].to_lower()
	var state_str: String = "ground" if player.state_machine.state.name == PlayerStates.GROUND else "air"
	var attack_str: String = type_str + "_" + direction_str + "_" + state_str + "_attack"
	
	assert(has_method(attack_str))
	call(attack_str)

func _finish_attack() -> void:
	if player.state_machine.state.name == PlayerStates.ATTACK:
		player.calculate_transition()

func light_side_ground_attack() -> void:
	pass

func light_side_air_attack() -> void:
	pass

func light_up_ground_attack() -> void:
	pass

func light_up_air_attack() -> void:
	pass

func light_down_ground_attack() -> void:
	pass

func light_down_air_attack() -> void:
	pass

func heavy_side_ground_attack() -> void:
	pass

func heavy_side_air_attack() -> void:
	pass

func heavy_up_ground_attack() -> void:
	pass

func heavy_up_air_attack() -> void:
	pass

func heavy_down_ground_attack() -> void:
	pass

func heavy_down_air_attack() -> void:
	pass

func special_side_ground_attack() -> void:
	pass

func special_side_air_attack() -> void:
	pass

func special_up_ground_attack() -> void:
	pass

func special_up_air_attack() -> void:
	pass

func special_down_ground_attack() -> void:
	pass

func special_down_air_attack() -> void:
	pass
