class_name WeaponEnergy

signal used(amount: float)
signal changed(new_value: float)

var max_value: float = 100
var value: float = 0 : set = _set_value

func _set_value(new_value: float) -> void:
	var old_value: = value
	value = clamp(new_value, 0, max_value)
	
	if value < old_value:
		used.emit(old_value - value)
	
	changed.emit(value)
