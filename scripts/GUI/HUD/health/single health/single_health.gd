class_name SingleHealth extends Panel

@onready var health: ColorRect = $Health

func update(whole: bool) -> void:
	health.visible = whole
