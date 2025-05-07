extends Node


func _on_hurtbox_hurt(attack_resource: AttackResource, defense_resource: DefenseResource) -> void:
	print("player hurt: ", attack_resource.damage)
