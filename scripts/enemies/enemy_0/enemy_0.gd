extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var health: Health = $Components/Health
@onready var gravity: Gravity = $Components/Gravity

func _process(delta: float) -> void:
	gravity.apply_gravity(delta)
	move_and_slide()


func _on_health_died() -> void:
	queue_free()

func _on_hurtbox_hurt(attack_resource: AttackResource, _attack_position: Vector2, _defense_resource: DefenseResource, _defense_position: Vector2) -> void:
	health.value -= attack_resource.damage
