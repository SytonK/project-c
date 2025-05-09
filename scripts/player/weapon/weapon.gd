class_name Weapon extends Node2D

enum AttackType {LIGHT, HEAVY, SPECIAL, DASH}

var player: Player

func attack(attack_type: AttackType) -> void:
	var type_str: String = AttackType.keys()[attack_type].to_lower()
	var direction_str: String = PlayerInput.InputDirection.keys()[PlayerInput.get_input_direction()].to_lower()
	var state_str: String = "ground" if player.state_machine.state.name == PlayerStates.GROUND else "air"
	var attack_str: String = type_str + "_" + direction_str + "_" + state_str + "_attack"
	
	print(attack_str)
