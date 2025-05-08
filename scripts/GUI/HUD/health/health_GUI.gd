class_name HealthGUI extends HBoxContainer

const SINGLE_HEALTH = preload("res://scenes/GUI/HUD/health/single health/single_health.tscn")

var max_health: int = 0
var current_health: int : set = _set_current_health
var healths: Array[SingleHealth]

func set_health(health: Health) -> void:
	_set_max_health(int(health.max_value))
	health.value_changed.connect(_set_current_health)

func _set_max_health(new_max_health: int) -> void:
	max_health = new_max_health
	for i in range(max_health):
		var new_single_health = SINGLE_HEALTH.instantiate()
		add_child(new_single_health)
	
	_set_new_healths()
	
	current_health = max_health

func _set_new_healths() -> void:
	for child in get_children():
		if child is SingleHealth:
			healths.append(child)

func _set_current_health(new_health: int) -> void:
	if max_health == 0:
		return
	
	assert(new_health >= 0, "GUI Health less then 0")
	assert(new_health <= max_health, "GUI Health more then max health")
	
	if new_health < current_health:
		for i in range(new_health, current_health):
			healths[i].update(false)
	
	if new_health > current_health:
		for i in range(current_health, new_health):
			healths[i].update(true)
	
	current_health = new_health
