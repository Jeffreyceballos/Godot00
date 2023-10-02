extends StaticBody2D

onready var tween := $Tween
onready var initial_position := position

var is_open := false

func activate() -> void:
	is_open = not is_open
	var target_position := initial_position
	if is_open:
		target_position.y += 260
	# If we toggle the door while it is animating, we must first erase and stop
	# the existing animation. Tween.remove_all() does both for us.
	tween.remove_all()
	tween.interpolate_property(
		self,
		"position",
		position,
		target_position,
		0.8,
		tween.TRANS_EXPO,
		Tween.EASE_OUT
	)
	tween.start()
	pass
