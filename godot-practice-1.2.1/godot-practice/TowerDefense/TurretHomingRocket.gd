extends "turret.gd"

func _on_Timer_timeout() -> void:
	if not target:
		return
	var rocket:= preload("common/RocketHoming.tscn").instance()
	add_child(rocket)
	rocket.global_transform = cannon.global_transform
	rocket.target = target
	rocket.set_initial_velocity()
