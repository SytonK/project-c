extends PlayerState

func enter(_previuse_state_name: String = "", _data: Dictionary = {}) -> void:
	print("enter air")

func exit() -> void:
	print("exit air")

func process(_delta: float) -> void:
	print("process air")

func physics_process(_delta: float) -> void:
	print("physics_process air")

func input(_event: InputEvent) -> void:
	print("input air")
