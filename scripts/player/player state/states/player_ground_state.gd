extends PlayerState

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	print("enter ground")

func exit() -> void:
	print("exit ground")

func process(_delta: float) -> void:
	print("process ground")

func physics_process(_delta: float) -> void:
	print("physics_process ground")

func input(_event: InputEvent) -> void:
	print("input ground")
