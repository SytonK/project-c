extends BehaviorTree

@export var animation_player: AnimationPlayer

@onready var play_animation_leaf: PlayAnimationLeaf = $SequenceComposite/PlayAnimationLeaf

func _ready() -> void:
	super._ready()
	play_animation_leaf.animation_player = animation_player
