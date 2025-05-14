class_name Ability extends Node

signal casted

@export var cooldown: float : set = _set_cooldown

var is_on_cooldown: bool = false
var cooldown_timer: Timer

func _ready() -> void:
	_init_cooldown()

func cast() -> void:
	if _can_cast():
		_pay_for_cast()
		_ability_effect()
		_recharge()
		casted.emit()

func _ability_effect() -> void:
	pass

func _can_cast() -> bool:
	return _cooldown_can_cast()

func _pay_for_cast() -> void:
	_cooldown_pay_for_cast()

func _recharge() -> void:
	_cooldown_recharge()

func _init_cooldown() -> void:
	cooldown_timer = Timer.new()
	if cooldown != 0:
		cooldown_timer.wait_time = cooldown
	cooldown_timer.one_shot = true
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeour)
	add_child(cooldown_timer)

func _on_cooldown_timer_timeour() -> void:
	is_on_cooldown = false

func _cooldown_can_cast() -> bool:
	return !is_on_cooldown

func _cooldown_pay_for_cast() -> void:
	assert(is_on_cooldown == false, "Try to pay for cooldown while on cooldown")
	is_on_cooldown = true

func _cooldown_recharge() -> void:
	if cooldown_timer && cooldown != 0:
		cooldown_timer.start()
	else:
		is_on_cooldown = false

func charge_cooldown(charge_time: float) -> void:
	var new_wait_time: float = max(cooldown_timer.time_left - charge_time, 0)
	cooldown_timer.start(new_wait_time)
	cooldown_timer.wait_time = cooldown

func _set_cooldown(new_cooldown: float) -> void:
	cooldown = new_cooldown
	if cooldown_timer && cooldown != 0:
		cooldown_timer.wait_time = cooldown
