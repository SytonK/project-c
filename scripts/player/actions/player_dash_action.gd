class_name PlayerDashAction extends EnergyAbility

@export var dash_force: float
@export var dash_duration: float

var player: Player

func _ready() -> void:
	super._ready()
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerDashAction was used on an owner that is not a Player")

func _ability_effect() -> void:
	player.state_machine.transition(PlayerStates.DASH, {"dash_force": dash_force, "dash_duration": dash_duration})
	player.velocity.x = dash_force
