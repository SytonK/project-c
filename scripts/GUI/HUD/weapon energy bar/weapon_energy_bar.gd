class_name WeaponEnergyBar extends ProgressBar

var weapon: Weapon : set = _set_weapon

func _set_weapon(new_weapon: Weapon) -> void:
	weapon = new_weapon
	weapon.weapon_energy.changed.connect(_set_value)
	_set_value(weapon.weapon_energy.value)

func _set_value(new_value: float) -> void:
	value = new_value
