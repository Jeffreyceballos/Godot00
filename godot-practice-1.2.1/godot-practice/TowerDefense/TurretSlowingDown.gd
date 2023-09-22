extends "turret.gd"

# The amount by which we divide the speed of mobs in range of the turret.
const SPEED_DIVIDER := 2.0

# We use this color to tint the mobs in range.
const COLOR := Color(0.4, 0.6, 1.0)

func _ready() -> void:
	set_physics_process(false)

func _on_Timer_timeout() -> void:
	return

func _on_body_entered(body: Node) -> void:
	._on_body_entered(body)
	body.speed /= SPEED_DIVIDER
	body.modulate = COLOR
	return

func _on_body_exited(body: Node) -> void:
	._on_body_exited(body)
	body.speed *= SPEED_DIVIDER
	body.modulate = Color(1.0, 1.0, 1.0)
