class_name DualGunsLishtSide extends Ability

const DUAL_GUN_LIGHT_SIDE_0 = preload("res://data/player/weapons/dual guns/dual_gun_light_side_0.tres")
const BASE_BULLET_SPEED: float = 1000
const BULLET_LIFE_TIME: float = .4
const BULLET_0 = preload("res://assets/sprites/player/weapons/dual guns/bullet 0.png")

var player: Player
var weapon: Weapon

func _ready() -> void:
	super._ready()
	assert(owner is Weapon, "weapon ability was used not on a weapon")
	weapon = owner
	await weapon.ready
	player = weapon.player

func _ability_effect() -> void:
	var new_bullet := Bullet.new(DUAL_GUN_LIGHT_SIDE_0, BASE_BULLET_SPEED, Vector2(player.get_facing_direction_to_float(), 0), BULLET_LIFE_TIME, BULLET_0)
	new_bullet.global_position = weapon.global_position
	get_tree().root.add_child(new_bullet)
