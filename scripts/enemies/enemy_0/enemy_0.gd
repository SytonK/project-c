extends CharacterBody2D

@export var target: Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var health: Health = $Components/Health
@onready var gravity: Gravity = $Components/Gravity
@onready var facing_direction: FacingDirection = $Components/FacingDirection

@onready var side_movement_to_target: SideMovementTask = $TaskRoot/TaskSelector/TaskSequence/SideMovementToTarget
@onready var look_at_target_task: LookAtTargetTask = $TaskRoot/TaskSelector/TaskSequence/LookAtTargetTask

func _ready() -> void:
	_init_behave_tree()

func _init_behave_tree() -> void:
	side_movement_to_target.targer = target
	look_at_target_task.targer = target

func _process(delta: float) -> void:
	gravity.apply_gravity(delta)
	move_and_slide()
	look_at_movement_direction()

func _on_health_died() -> void:
	queue_free()

func _on_hurtbox_hurt(attack_resource: AttackResource, _attack_position: Vector2, _defense_resource: DefenseResource, _defense_position: Vector2) -> void:
	health.value -= attack_resource.damage

func look_at_movement_direction() -> void:
	if velocity.x > 0:
		facing_direction.direction = FacingDirection.DIRECTIONS.RIGHT
	elif velocity.x < 0:
		facing_direction.direction = FacingDirection.DIRECTIONS.LEFT
