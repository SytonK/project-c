class_name WeaponChild extends Node

var player: Player
var weapon: Weapon

func _ready() -> void:
	assert(owner is Weapon, "WeaponChild was used not on a weapon")
	weapon = owner
	await owner.ready
	player = owner.player
