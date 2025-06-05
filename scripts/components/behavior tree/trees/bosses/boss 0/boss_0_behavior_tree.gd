extends BehaviorTree

@export var target: Player

@export var side_movement_action: SideMovementAction

@onready var in_range_melle: InRange = $SelectComposite/InRangeMelle
@onready var in_range_mid: InRange = $SelectComposite/InRangeMid
@onready var side_move_to_target_leaf: SideMoveToTargetLeaf = $SelectComposite/InRangeMelle/SequenceComposite/SideMoveToTargetLeaf

func _ready() -> void:
	super._ready()
	await owner.ready
	
	in_range_melle.target = target
	in_range_melle.source = owner
	
	in_range_mid.target = target
	in_range_mid.source = owner
	
	side_move_to_target_leaf.target = target
	side_move_to_target_leaf.side_movement_action = side_movement_action
