class_name AxeLightSide extends WeaponChild

const ENERGY_COST: float = 12
const PUSH_BACK_SIDE_FORCE: float = 600

const LIGHT_SIDE_SWING_BASE = preload("res://data/player/weapons/axe/light side swing 0/light side swing base.tres")
const LIGHT_SIDE_SWING_HEANDLE_0 = preload("res://data/player/weapons/axe/light side swing 0/light side swing heandle 0.tres")

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var axe_head_shape: MultiRegionHitShape = $"../MultiRegionHitbox/AxeHeadShape"
@onready var axe_handle_shape: MultiRegionHitShape = $"../MultiRegionHitbox/AxeHandleShape"

func _on_handle_hit(attack_resource: AttackResource, defense_resource: DefenseResource, defense_position: Vector2) -> void:
	_push_back_on_handle_hit()

func _push_back_on_handle_hit() -> void:
	player.velocity.x = (-1 if player.facing_direction == Player.FACING_DIRECTIONS.RIGHT else 1) * PUSH_BACK_SIDE_FORCE

func finish_side_attack() -> void:
	axe_handle_shape.hit.disconnect(_on_handle_hit)
	player.velocity.x = 0

func light_side_0() -> void:
	player.state_machine.transition(PlayerStates.ATTACK)
	player.velocity.x = 0
	player.velocity.y = max(player.velocity.y, 0)
	animation_player.play("light_side_swing_0")
	
	if weapon.weapon_energy.value >= ENERGY_COST:
		weapon.weapon_energy.value -= ENERGY_COST
		axe_head_shape.attack_resource = LIGHT_SIDE_SWING_HEANDLE_0
		axe_handle_shape.hit.connect(_on_handle_hit)
	else:
		axe_head_shape.attack_resource = LIGHT_SIDE_SWING_BASE
