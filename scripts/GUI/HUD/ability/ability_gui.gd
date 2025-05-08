class_name AbilityGUI extends TextureProgressBar

const SQUARE_ICON = preload("res://assets/temp assets/square-icon.png")
const BACKGROUND_A: float = 0.3

var ability: Ability 

func _ready() -> void:
	set_process(false)
	fill_mode = FillMode.FILL_CLOCKWISE
	texture_under = SQUARE_ICON
	tint_under.a = BACKGROUND_A

func set_ability(new_ability: Ability) -> void:
	ability = new_ability
	_set_value()
	ability.casted.connect(_start)

func _start() -> void:
	set_process(true)

func _process(_delta: float) -> void:
	_set_value()
	if value >= max_value:
		set_process(false)

func _set_value() -> void:
	value = ((ability.cooldown - ability.cooldown_timer.time_left) / ability.cooldown) * 100
