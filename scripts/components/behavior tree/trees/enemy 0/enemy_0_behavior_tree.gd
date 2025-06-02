extends BehaviorTree

@export var animation_player: AnimationPlayer
@export var side_movement_action: SideMovementAction
@export var facing_direction: FacingDirection
@export var target: Node2D

@onready var play_animation_leaf: PlayAnimationLeaf = $SequenceComposite/PlayAnimationLeaf
@onready var side_move_to_target_leaf: SideMoveToTargetLeaf = $SequenceComposite/SideMoveToTargetLeaf
@onready var look_at_target_leaf: LookAtTargetLeaf = $SequenceComposite/LookAtTargetLeaf

func _ready() -> void:
	super._ready()
	await owner.ready
	play_animation_leaf.animation_player = animation_player
	
	side_move_to_target_leaf.side_movement_action = side_movement_action
	side_move_to_target_leaf.target = target
	
	look_at_target_leaf.facing_direction = facing_direction
	look_at_target_leaf.target = target
