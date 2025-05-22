class_name WeaponHelper

static func get_weapon_owner(node: Node) -> Weapon:
	assert(node.owner is Weapon, "get_weapon_owner was used not on a weapon")
	return node.owner as Weapon
