extends BehaviorTree

@export var target: Player

@export var side_movement_action: SideMovementAction
@export var facing_direction: FacingDirection

@onready var in_range_melle: InRange = $SelectComposite/InRangeMelle
@onready var in_range_mid: InRange = $SelectComposite/InRangeMid
@onready var side_move_to_target_leaf: SideMoveToTargetLeaf = $SelectComposite/InRangeMelle/SequenceComposite/SideMoveToTargetLeaf
@onready var look_at_target_leaf: LookAtTargetLeaf = $SelectComposite/InRangeMelle/SequenceComposite/LookAtTargetLeaf

func _ready() -> void:
	super._ready()
	await owner.ready
	
	in_range_melle.target = target
	in_range_melle.source = owner
	
	in_range_mid.target = target
	in_range_mid.source = owner
	
	side_move_to_target_leaf.target = target
	side_move_to_target_leaf.side_movement_action = side_movement_action
	
	look_at_target_leaf.target = target
	look_at_target_leaf.facing_direction = facing_direction
