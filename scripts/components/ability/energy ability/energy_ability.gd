class_name EnergyAbility extends Ability

@export var max_energy: int
@export var recharge_energy_time: float

@onready var energy: int = max_energy
var energy_timer: Timer

func _ready() -> void:
	super._ready()
	_init_energy()

func _can_cast() -> bool:
	return super._can_cast() && _energy_can_cast()

func _pay_for_cast() -> void:
	super._pay_for_cast()
	_energy_pay_for_cast()

func _recharge() -> void:
	super._recharge()
	_energy_recharge()

func _init_energy() -> void:
	if recharge_energy_time == 0:
		return
	
	energy_timer = Timer.new()
	energy_timer.wait_time = recharge_energy_time
	energy_timer.one_shot = true
	energy_timer.timeout.connect(_on_energy_timer_timeour)
	add_child(energy_timer)

func _on_energy_timer_timeour() -> void:
	energy += 1
	assert(energy <= max_energy)
	
	if energy < max_energy:
		energy_timer.start()

func _energy_can_cast() -> bool:
	return energy > 0

func _energy_pay_for_cast() -> void:
	assert(energy > 0)
	energy -= 1

func  _energy_recharge() -> void:
	if energy_timer.time_left == 0:
		energy_timer.start()
