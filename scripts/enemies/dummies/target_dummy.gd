extends Node2D

const LABEL_FADE_DURATION: float = .4

@onready var label: Label = $Label

var label_tween: Tween

func _show_damage_label_effect(damage: float) -> void:
	if label_tween:
		label_tween.stop()
	
	label.text = str(damage)
	label.modulate = Color(1,1,1,1)
	
	label_tween = create_tween()
	label_tween.tween_property(label, "modulate", Color(1,1,1,0), LABEL_FADE_DURATION)


func _on_hurtbox_hurt(attack_resource: AttackResource, _attack_position: Vector2, _defense_resource: DefenseResource, _defense_position: Vector2) -> void:
	_show_damage_label_effect(attack_resource.damage)
	
