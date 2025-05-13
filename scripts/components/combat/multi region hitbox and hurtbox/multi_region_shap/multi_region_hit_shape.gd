class_name MultiRegionHitShape extends CollisionShape2D

signal hit(attack_resource: AttackResource, defense_resource: DefenseResource, defense_position: Vector2)

@export var attack_resource: AttackResource

func on_hit(defense_resource: DefenseResource, defense_position: Vector2) -> void:
	hit.emit(attack_resource, defense_resource, defense_position)
