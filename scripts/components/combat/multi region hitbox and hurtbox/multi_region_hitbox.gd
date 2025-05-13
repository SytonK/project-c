class_name MultiRegionHitbox extends Area2D

signal hit(attack_resource: AttackResource, attack_position: Vector2, defense_resource: DefenseResource, defense_position: Vector2)

func _init() -> void:
	collision_mask = 0

func _ready() -> void:
	for child in get_children():
		if child is MultiRegionHitShape:
			child.hit.connect(_on_hit)

func _on_hit(attack_resource: AttackResource, attack_position: Vector2, defense_resource: DefenseResource, defense_position: Vector2) -> void:
	hit.emit(attack_resource, attack_position, defense_resource, defense_position)
