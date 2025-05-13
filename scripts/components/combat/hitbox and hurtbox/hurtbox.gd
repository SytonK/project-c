class_name Hurtbox extends Area2D

signal hurt(attack_resource: AttackResource, attack_position: Vector2, defense_resource: DefenseResource, defense_position: Vector2)

@export var defense_resource: DefenseResource

func _init() -> void:
	collision_layer = 0
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox:
		hurt.emit(hitbox.attack_resource, hitbox.global_position, defense_resource, global_position)
		
		hitbox.on_hit(self)
