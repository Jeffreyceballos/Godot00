extends "./Rocket.gd"

var velocity := Vector2.ZERO
var desired_velocity := Vector2.ZERO
var steering_vector := Vector2.ZERO
var drag_factor := 0.1

var target: Node = null

func _move(delta: float) -> void: 
	# If the target has not been set, or has been destroyed, we destroy this
	# rocket.
	if not target or not is_instance_valid(target):
		explode()
		return
	# calculate direction to target
	var direction := global_position.direction_to(target.global_position)
	desired_velocity = direction * speed
	steering_vector = desired_velocity - velocity
	velocity += steering_vector * drag_factor
	position += velocity*delta
	rotation = velocity.angle()
	
func set_initial_velocity() -> void:
	velocity = transform.x *speed
