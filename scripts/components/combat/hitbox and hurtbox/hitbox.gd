class_name Hitbox extends Area2D

signal hit(hitbox: Hitbox, hurtbox: Hurtbox)

@export var attack_resource: AttackResource

func _init() -> void:
	collision_mask = 0
 
func on_hit(hurtbox: Hurtbox) -> void:
	hit.emit(self, hurtbox)
