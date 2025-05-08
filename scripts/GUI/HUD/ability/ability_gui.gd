class_name AbilityGUI extends TextureProgressBar

const SQUARE_ICON = preload("res://assets/temp assets/square-icon.png")

var ability: Ability 

func _ready() -> void:
	set_process(false)
	fill_mode = FillMode.FILL_CLOCKWISE
	texture_under = SQUARE_ICON
	tint_under.a = .3

func set_ability(new_ability: Ability) -> void:
	ability = new_ability
	value = 100
	ability.casted.connect(_start)

func _start() -> void:
	set_process(true)

func _process(delta: float) -> void:
	value = ((ability.cooldown - ability.cooldown_timer.time_left) / ability.cooldown) * 100
	if value >= max_value:
		set_process(false)
	
