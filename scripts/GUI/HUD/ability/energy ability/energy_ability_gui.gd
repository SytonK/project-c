class_name EnergyAbilityGUI extends TextureProgressBar

const SQUARE_ICON = preload("res://assets/temp assets/square-icon.png")
const BACKGROUND_A: float = 0.3

var max_energy: int
var energy: int : set = _set_energy

var energy_ability: EnergyAbility

var label: Label

func _ready() -> void:
	_init_label()
	set_process(false)
	fill_mode = FillMode.FILL_CLOCKWISE
	texture_under = SQUARE_ICON
	tint_under.a = BACKGROUND_A

func set_energy_ability(new_energy_ability: EnergyAbility) -> void:
	energy_ability = new_energy_ability
	_set_value()
	max_energy = energy_ability.max_energy
	energy = energy_ability.energy
	energy_ability.casted.connect(_start)

func _start() -> void:
	set_process(true)
	
func _process(_delta: float) -> void:
	_set_value()
	energy = energy_ability.energy
	if energy == max_energy:
		set_process(false)

func _set_value() -> void:
	value = ((energy_ability.recharge_energy_time - energy_ability.energy_timer.time_left) / energy_ability.recharge_energy_time) * 100

func _init_label() -> void:
	label = Label.new()
	add_child(label)

func _set_label_text() -> void:
	label.text = str(energy) + " / " + str(max_energy)

func _set_energy(new_energy: int) -> void:
	energy = new_energy
	_set_label_text()

func _set_max_energy(new_max_energy: int) -> void:
	max_energy = new_max_energy
	_set_label_text()
