class_name TaskHelper

static func get_bt_nodes(parent_task: Task) -> Array[Task]:
	var tasks: Array[Task]
	for child in parent_task.get_children():
		if child is Task:
			tasks.append(child)
	return tasks
