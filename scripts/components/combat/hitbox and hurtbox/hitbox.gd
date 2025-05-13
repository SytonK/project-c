class_name Hitbox extends Area2D

signal hit(attack_resource: AttackResource, attack_position: Vector2, defense_resource: DefenseResource, defense_position: Vector2)

@export var attack_resource: AttackResource

func _init() -> void:
	collision_mask = 0
 
func on_hit(hurtbox: Hurtbox) -> void:
	hit.emit(attack_resource, global_position, hurtbox.defense_resource, hurtbox.global_position)
