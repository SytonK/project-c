extends CharacterBody2D

@onready var health: Health = $Health

func _on_health_died() -> void:
	queue_free()
