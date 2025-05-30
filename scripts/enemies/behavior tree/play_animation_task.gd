class_name PlayAnimationTask extends Task

@export var animation_player: AnimationPlayer
@export var animation_name: String
@export var wait_for_animation_to_finish: bool
var is_animation_finished: bool = false

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	assert(animation_player, "PlayAnimationTask needs animation player")
	assert(animation_player.has_animation(animation_name), "PlayAnimationTask has no animation named " + animation_name)
	
	if(!wait_for_animation_to_finish):
		animation_player.play(animation_name)
		return States.SUCCEEDED
	elif(is_animation_finished):
		is_animation_finished = false
		animation_player.animation_finished.disconnect(_on_animation_player_animation_finished)
		return States.SUCCEEDED
	else:
		if(!animation_player.current_animation == animation_name):
			animation_player.animation_finished.connect(_on_animation_player_animation_finished)
			animation_player.play(animation_name)
		return States.RUNNING


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == animation_name):
		is_animation_finished = true
