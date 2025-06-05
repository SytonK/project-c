extends CharacterBody2D

@export var target: Node2D

@onready var boss_0_behavior_tree: Node = $Boss0BehaviorTree

@onready var health: Health = $Compontnts/Health
@onready var gravity: Gravity = $Compontnts/Gravity
@onready var facing_direction: FacingDirection = $Compontnts/FacingDirection

func _ready() -> void:
	boss_0_behavior_tree.target = target

func _physics_process(delta: float) -> void:
	gravity.apply_gravity(delta)
	
	move_and_slide()
	
	_look_at_movement_direction()

func _look_at_movement_direction() -> void:
	if velocity.x > 0:
		facing_direction.direction = FacingDirection.DIRECTIONS.RIGHT
	elif velocity.x < 0:
		facing_direction.direction = FacingDirection.DIRECTIONS.LEFT

func _on_hurtbox_hurt(attack_resource: AttackResource, _attack_position: Vector2, _defense_resource: DefenseResource, _defense_position: Vector2) -> void:
	health.value -= attack_resource.damage

func _on_health_died() -> void:
	queue_free()
