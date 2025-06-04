extends Node2D

@export var target: Node2D

@onready var boss_0_behavior_tree: Node = $Boss0BehaviorTree

func _ready() -> void:
	boss_0_behavior_tree.target = target
