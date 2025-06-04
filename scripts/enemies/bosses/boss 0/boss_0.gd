extends Node2D

@export var target: Node2D

@onready var boss_0_behavior_tree: Node = $Boss0BehaviorTree

@onready var health: Health = $Compontnts/Health

func _ready() -> void:
	boss_0_behavior_tree.target = target

func _on_hurtbox_hurt(attack_resource: AttackResource, _attack_position: Vector2, _defense_resource: DefenseResource, _defense_position: Vector2) -> void:
	health.value -= attack_resource.damage

func _on_health_died() -> void:
	queue_free()
