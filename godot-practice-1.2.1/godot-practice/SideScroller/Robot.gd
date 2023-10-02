extends KinematicBody2D

export var speed := 600.0
export var gravity := 4500.0
export var jump_strengths := [1400.0, 1000.0]

var jump_number := 0
var velocity := Vector2.ZERO
var test := Vector2.ZERO

func _physics_process(delta: float) -> void:
	 # Get the horizontal direction as a number between -1.0 and 1.0.
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	# Multiply the direction by speed, and assign to the velocity's x value.
	velocity.x = horizontal_direction * speed
	# Add the gravity to the velocity's y value.
	velocity.y += gravity * delta
	
	# If the character is jumping and there are jumps remaining.
	var is_jumping := Input.is_action_just_pressed("jump")
	var is_jump_cancelled := velocity.y < 0.0 and Input.is_action_just_released("jump")
	if is_jumping and jump_number < jump_strengths.size():
		# Apply the current jump's strength and increment the jump number.
		velocity.y = -jump_strengths[jump_number]
		jump_number += 1
	elif is_jump_cancelled: 
		velocity.y = 0.0
	# While the character is on the floor, restore all jumps.
	elif is_on_floor():
		jump_number = 0
	
	# Move this kinematic body based on its velocity.
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI / 4, false)
	#if velocity != test:
	#	print(str(velocity.x)+", "+str(velocity.y))
	#	test = velocity
	for index in get_slide_count():
		var collision := get_slide_collision(index)
		if collision.collider is RigidBody2D:
			var impulse := -collision.normal * 5000 * delta
			collision.collider.apply_central_impulse(impulse)
			pass
	pass
