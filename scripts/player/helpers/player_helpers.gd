class_name PlayerHelpers extends Node

static func get_player_owner(node: Node) -> Player:
	assert(node.owner is Player, "The get_player_owner was used on an owner that is not a Player")
	return node.owner as Player
