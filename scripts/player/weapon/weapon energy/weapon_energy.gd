class_name WeaponEnergy

signal used(amount: float)

var max_value: float = 100
var value: = 0 : set = _set_value

func _set_value(new_value: float) -> void:
	var res = clamp(new_value, 0, max_value)
	
	if res < value:
		used.emit(value - res)
	
	value = res
