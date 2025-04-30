class_name PlayerWallJumpAction extends Node

@export var jump_force: float
@export var jump_pushback_force: float

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerWallJumpAction was used on an owner that is not a Player")

func jump() -> void:
	var jump_direction: int = 1 if player.facing_direction == Player.FACING_DIRECTIONS.RIGHT else -1
	owner.velocity = Vector2(jump_pushback_force * jump_direction, -jump_force)
