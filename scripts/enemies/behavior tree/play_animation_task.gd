class_name PlayAnimationTask extends Task

@export var animation_player: AnimationPlayer
@export var animation_name: String

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	assert(animation_player, "PlayAnimationTask needs animation player")
	assert(animation_player.has_animation(animation_name), "PlayAnimationTask has no animation named " + animation_name)
	animation_player.play(animation_name)
	return States.SUCCEEDED
