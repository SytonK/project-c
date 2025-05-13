class_name MultiRegionHitShape extends CollisionShape2D

signal hit(attack_resource: AttackResource, attack_position: Vector2, defense_resource: DefenseResource, defense_position: Vector2)

@export var attack_resource: AttackResource

func on_hit(defense_resource: DefenseResource, position: Vector2) -> void:
	hit.emit(attack_resource, global_position, defense_resource, position)
