extends BehaviorTree

@export var animation_player: AnimationPlayer
@export var side_movement_action: SideMovementAction
@export var target: Node2D

@onready var play_animation_leaf: PlayAnimationLeaf = $SequenceComposite/PlayAnimationLeaf
@onready var side_move_to_target_leaf: SideMoveToTargetLeaf = $SequenceComposite/SideMoveToTargetLeaf

func _ready() -> void:
	super._ready()
	await owner.ready
	play_animation_leaf.animation_player = animation_player
	
	side_move_to_target_leaf.side_movement_action = side_movement_action
	side_move_to_target_leaf.target = target
