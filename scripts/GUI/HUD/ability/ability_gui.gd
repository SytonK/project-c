class_name AbilityGUI extends TextureProgressBar

const SQUARE_ICON = preload("res://assets/temp assets/square-icon.png")

var cooldown: float 

func _ready() -> void:
	set_process(false)
	fill_mode = FillMode.FILL_CLOCKWISE
	texture_under = SQUARE_ICON
	tint_under.a = .3

func set_ability(ability: Ability) -> void:
	cooldown = ability.cooldown
	value = 100
	ability.casted.connect(_start)

func _start() -> void:
	set_process(true)
	value = 0

func _process(delta: float) -> void:
	value += delta * 100 / cooldown
	if value >= max_value:
		set_process(false)
	
