class_name State extends Node

@warning_ignore("unused_signal")
signal transition(new_state_name: String, data: Dictionary)

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func input(_event: InputEvent) -> void:
	pass
