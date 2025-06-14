class_name DualGunsLightDownGround extends Ability

const DUAL_GUNS_LIGHT_DOWN_GROUND = preload("res://data/player/weapons/dual guns/light/down/dual_guns_light_down_ground.tres")
const BULLET_0 = preload("res://assets/sprites/player/weapons/dual guns/bullet 0.png")
const BULLET_1 = preload("res://assets/sprites/player/weapons/dual guns/bullet 1.png")
const Y_DIRECTION: float = .25
const ENERGY_COST: float = 15

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

@onready var weapon: Weapon = WeaponHelper.get_weapon_owner(self)
@onready var player: Player = weapon.player

func _ability_effect() -> void:
	_set_up_attack()
	animation_player.play("light_down_ground")

func _set_up_attack() -> void:
	player.state_machine.transition(PlayerStates.ATTACK)
	player.velocity.x = 0

func spawn_bullet_0() -> void:
	_spawn_bullet(player.facing_direction.get_float(), BULLET_0)

func spawn_bullet_1() -> void:
	_spawn_bullet(-player.facing_direction.get_float(), BULLET_1)

func _spawn_bullet(x_direction: float, texture: Texture2D) -> void:
	var attack_resourc: AttackResource
	var speed: float
	var bounce: bool = false
	if weapon.weapon_energy.value >= ENERGY_COST:
		attack_resourc = DUAL_GUNS_LIGHT_DOWN_GROUND
		speed = Bullet.FAST_BULLET_SPEED
		bounce = true
		weapon.weapon_energy.value -= ENERGY_COST
	else:
		attack_resourc = Bullet.DUAL_GUNS_LIGHT_BASE
		speed = Bullet.BASE_BULLET_SPEED
	var new_bullet := Bullet.new(texture, Vector2(x_direction, Y_DIRECTION), attack_resourc, speed, bounce)
	new_bullet.global_position = weapon.global_position
	get_tree().root.add_child(new_bullet)
