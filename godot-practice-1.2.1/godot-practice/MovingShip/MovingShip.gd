extends Sprite

var normal_speed := 600.0
var boost_speed := 1500.0

var max_speed := normal_speed

var desired_velocity := Vector2.ZERO
var steering_vector := Vector2.ZERO
var velocity := Vector2.ZERO

var drag_factor := 0.1

func _process(delta: float) -> void:
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.length() > 1.0:
			direction = direction.normalized()
	
	if Input.is_action_just_pressed("boost"):
		max_speed = boost_speed
		get_node("Timer").start()
	
	#velocity = direction * max_speed
	desired_velocity = direction * max_speed
	steering_vector = desired_velocity - velocity
	velocity += steering_vector * drag_factor
	
	position += velocity * delta
	if direction:
		rotation = velocity.angle()


func _on_Timer_timeout() -> void:
	max_speed = normal_speed
