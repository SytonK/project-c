class_name PlayerWallJumpAction extends Node

@export var jump_force: float
@export var jump_pushback_force: float

@onready var player: Player = PlayerHelpers.get_player_owner(self)

func jump() -> void:
	owner.velocity = Vector2(jump_pushback_force * player.get_facing_direction_to_float(), -jump_force)
