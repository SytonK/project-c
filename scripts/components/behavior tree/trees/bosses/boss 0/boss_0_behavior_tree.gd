extends BehaviorTree

@export var target: Player

@onready var in_range_melle: InRange = $SelectComposite/InRangeMelle
@onready var in_range_mid: InRange = $SelectComposite/InRangeMid

func _ready() -> void:
	super._ready()
	await owner.ready
	
	in_range_melle.target = target
	in_range_melle.source = owner
	
	in_range_mid.target = target
	in_range_mid.source = owner
	
