class_name WeaponManager extends Node2D

const UNARMED = preload("res://scenes/player/weapons/unarmed/unarmed.tscn")

var weapons: Array[Weapon]
var current_weapon_index: int = -1 : set = _set_current_weapon_index
var current_weapon: Weapon
var unarmed: Weapon

var player: Player

func _ready() -> void:
	await _init_player()
	_init_unarmed()

func _init_player() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The WeaponManager was used on an owner that is not a Player")

func _init_unarmed() -> void:
	unarmed = UNARMED.instantiate()
	unarmed.player = player
	add_child(unarmed)
	current_weapon = unarmed

func add_weapon(new_weapon: Weapon) -> void:
	new_weapon.player = player
	new_weapon.weapon_energy.used.connect(_use_weapon_energy)
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

func go_to_next_weapon() -> void:
	if weapons.size() > 0:
		current_weapon_index = posmod(current_weapon_index + 1, weapons.size())

func _use_weapon_energy(amount: float) -> void:
	assert(current_weapon_index != -1, 'Unarrmed attempted to use energy weapon')
	
	var weapon_index_to_charge: int = posmod(current_weapon_index + 1, weapons.size())
	weapons[weapon_index_to_charge].weapon_energy.value += amount

func attack(event: InputEvent) -> bool:
	if event.is_action_pressed("light_attack"):
		current_weapon.attack(Weapon.AttackType.LIGHT)
		return true
	elif event.is_action_pressed("heavy_attack"):
		current_weapon.attack(Weapon.AttackType.HEAVY)
		return true
	if event.is_action_pressed("special_attack"):
		current_weapon.attack(Weapon.AttackType.SPECIAL)
		return true
	return false
