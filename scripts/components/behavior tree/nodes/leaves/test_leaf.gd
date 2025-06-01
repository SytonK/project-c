class_name TestLeaf extends Leaf

func start(_blackboard: Dictionary = {}) -> void:
	print("start")

func tick(_delta: float, _blackboard: Dictionary = {}) -> States:
	print("tick")
	return States.RUNNING

func interrupt(_blackboard: Dictionary = {}) -> void:
	print("interrupt")
	pass

func end(_blackboard: Dictionary = {}) -> void:
	print("end")
	pass
