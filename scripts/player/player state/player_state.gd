class_name PlayerState extends State

const GROUND: String = "Ground"
const AIR: String = "Air"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState was used on an owner that is not a Player")
