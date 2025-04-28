class_name StopJumpAction extends Node

func stop_jump() -> void:
	assert(owner is CharacterBody2D, "Owner of the StopJumpAction component must be of type CharacterBody2D")
	if owner.velocity.y < 0:
		owner.velocity.y = 0
