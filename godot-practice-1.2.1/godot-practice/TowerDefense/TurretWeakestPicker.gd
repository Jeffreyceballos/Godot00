extends "./turret.gd"

func select_target() -> void:
	if target_list:
		target = target_list[0]
		for potential_target in target_list:
			if potential_target.health < target.health:
				target = potential_target
	else:
		target = null
		
