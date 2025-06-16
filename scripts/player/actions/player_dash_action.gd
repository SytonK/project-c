class_name PlayerDashAction extends EnergyAbility

@export var dash_force: float
@export var dash_duration: float

@export var disabled: bool = false

@onready var player: Player = PlayerHelpers.get_player_owner(self)

func _ability_effect() -> void:
	if(disabled):
		return
	
	player.state_machine.transition(PlayerStates.DASH, {"dash_force": dash_force, "dash_duration": dash_duration})
	player.velocity = Vector2(dash_force * player.get_input_side_direction(), 0)
