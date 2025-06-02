class_name PlayAnimationLeaf extends Leaf

@export var animation_player: AnimationPlayer
@export var animation_name: String
@export var wait_for_animation_to_finish: bool = false
var is_animation_finished: bool = false

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	assert(animation_player, "AnimationPlayer was not provided to AnimationPlayerLeaf")
	assert(animation_player.has_animation(animation_name),
	"AnimationPlayer is missing animation in AnimationPlayerLeaf. anim name: " + animation_name)
	
	if(!wait_for_animation_to_finish):
		animation_player.play(animation_name)
		return States.SUCCEEDED
	elif(is_animation_finished):
		is_animation_finished = false
		if(animation_player.animation_finished.is_connected(_on_animation_player_animation_finished)):
			animation_player.animation_finished.disconnect(_on_animation_player_animation_finished)
		return States.SUCCEEDED
	else:
		if(!animation_player.current_animation == animation_name):
			animation_player.play(animation_name)
		if(!animation_player.animation_finished.is_connected(_on_animation_player_animation_finished)):
			animation_player.animation_finished.connect(_on_animation_player_animation_finished)
		return States.RUNNING

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == animation_name):
		is_animation_finished = true

func interrupt(_blackboard: Dictionary = {}) -> void:
	is_animation_finished = false
	if(animation_player.current_animation == animation_name):
		animation_player.stop()
	if(animation_player.animation_finished.is_connected(_on_animation_player_animation_finished)):
		animation_player.animation_finished.disconnect(_on_animation_player_animation_finished)
	
