class_name Hurtbox extends Area2D

signal hurt(hitbox: Hitbox, hurtbox: Hurtbox)

@export var defense_resource: DefenseResource

func _init() -> void:
	collision_layer = 0
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox:
		hurt.emit(hitbox, self)
		
		hitbox.on_hit(self)
