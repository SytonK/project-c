class_name WeaponManager extends Node2D

const UNARMED = preload("res://scenes/player/weapons/unarmed/unarmed.tscn")

var weapons: Array[Weapon]
var current_weapon_index: int = -1 : set = _set_current_weapon_index
var current_weapon: Weapon
var unarmed: Weapon

func _ready() -> void:
	_init_unarmed()

func _init_unarmed() -> void:
	unarmed = UNARMED.instantiate()
	add_child(unarmed)
	current_weapon = unarmed

func add_weapon(new_weapon: Weapon) -> void:
	add_child(new_weapon)
	weapons.append(new_weapon)
	current_weapon_index = weapons.size() - 1

func remove_current_weapon() -> void:
	if current_weapon_index == -1:
		return
	
	current_weapon.queue_free()
	weapons.remove_at(current_weapon_index)
	current_weapon_index = -1 if weapons.size() == 0 else posmod(current_weapon_index, weapons.size())

func _set_current_weapon_index(new_current_weapon_index: int) -> void:
	current_weapon.visible = false
	
	current_weapon_index = new_current_weapon_index
	
	if current_weapon_index == -1:
		current_weapon = unarmed
	else:
		current_weapon = weapons[current_weapon_index]
	
	current_weapon.visible = true
	
	
func next_weapon() -> void:
	if weapons.size() > 0:
		current_weapon_index = posmod(current_weapon_index + 1, weapons.size())
