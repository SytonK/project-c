class_name Hitbox extends Area2D

signal hit(attack_resource: AttackResource, defense_resource: DefenseResource)

@export var attack_resource: AttackResource

func _init() -> void:
	collision_mask = 0
 
func on_hit(defense_resource: DefenseResource) -> void:
	hit.emit(attack_resource, defense_resource)
