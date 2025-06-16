extends BehaviorTree

@export var target: Player

@export var side_movement_action: SideMovementAction
@export var facing_direction: FacingDirection
@export var animation_player: AnimationPlayer

@onready var in_range_melle: InRange = $SelectComposite/MeleeSequenceComposite/InRangeMelle
@onready var melee_side_move_to_target_leaf: SideMoveToTargetLeaf = $SelectComposite/MeleeSequenceComposite/InRangeMelle/SequenceComposite/MeleeSideMoveToTargetLeaf
@onready var melee_look_at_target_leaf: LookAtTargetLeaf = $SelectComposite/MeleeSequenceComposite/InRangeMelle/SequenceComposite/MeleeLookAtTargetLeaf
@onready var play_animation_leaf_melee_attack_0: PlayAnimationLeaf = $SelectComposite/MeleeSequenceComposite/RandomSelectComposite/PlayAnimationLeafMeleeAttack0
@onready var play_animation_leaf_melee_attack_1: PlayAnimationLeaf = $SelectComposite/MeleeSequenceComposite/RandomSelectComposite/PlayAnimationLeafMeleeAttack1

@onready var in_range_mid: InRange = $SelectComposite/InRangeMid

func _ready() -> void:
	super._ready()
	await owner.ready
	
	in_range_melle.target = target
	in_range_melle.source = owner
	
	in_range_mid.target = target
	in_range_mid.source = owner
	
	melee_side_move_to_target_leaf.target = target
	melee_side_move_to_target_leaf.side_movement_action = side_movement_action
	
	melee_look_at_target_leaf.target = target
	melee_look_at_target_leaf.facing_direction = facing_direction
	
	play_animation_leaf_melee_attack_0.animation_player = animation_player
	play_animation_leaf_melee_attack_1.animation_player = animation_player
