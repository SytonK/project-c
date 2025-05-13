class_name Hurtbox extends Area2D

signal hurt(attack_resource: AttackResource, attack_position: Vector2, defense_resource: DefenseResource, defense_position: Vector2)

@export var defense_resource: DefenseResource

var allow_multi_region_shape_collision: bool = false

func _init() -> void:
	collision_layer = 0
	area_entered.connect(_on_area_entered)
	area_shape_entered.connect(_on_area_shape_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		_hitbox_entered(area)
	elif area is MultiRegionHitbox:
		_multi_region_hitbox_entered()

func _hitbox_entered(hitbox: Hitbox) -> void:
	hurt.emit(hitbox.attack_resource, hitbox.global_position, defense_resource, global_position)
	hitbox.on_hit(defense_resource, global_position)

func _multi_region_hitbox_entered() -> void:
	allow_multi_region_shape_collision = true

func _on_area_shape_entered(_area_rid: RID, area: MultiRegionHitbox, area_shape_index: int, _local_shape_index: int) -> void:
	if !allow_multi_region_shape_collision:
		return
	
	var hit_shape: MultiRegionHitShape = _get_hit_shape(area, area_shape_index)
	
	hurt.emit(hit_shape.attack_resource, hit_shape.global_position, defense_resource, global_position)
	hit_shape.on_hit(defense_resource, global_position)
	
	allow_multi_region_shape_collision = false

func _get_hit_shape(area: MultiRegionHitbox, area_shape_index: int) -> MultiRegionHitShape:
	var other_shape_owner: int = area.shape_find_owner(area_shape_index)
	var other_shape_node: Object = area.shape_owner_get_owner(other_shape_owner)
	assert(other_shape_node is MultiRegionHitShape, "Shape that hit the MultiRegionHurtbox is not a MultiRegionHitShape")
	return other_shape_node as MultiRegionHitShape
