extends "./turret.gd"

func _on_Timer_timeout() -> void:
	for target in target_list:
		var rocket := preload("common/Rocket.tscn").instance()
		add_child(rocket)
		rocket.rotation = target.global_position.angle_to_point(cannon.global_position)
		rocket.global_position = cannon.global_position

func _rotate_to_target() -> void:
	var target_angle := PI / 2.0
	if target_list:
		var average_position := Vector2.ZERO
		for target in target_list:
			average_position += target.global_position
		average_position /= target_list.size()
		target_angle = average_position.angle_to_point(global_position)
	sprite.rotation = lerp_angle(sprite.rotation, target_angle, rotation_factor)
