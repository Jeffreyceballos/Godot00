extends KinematicBody2D

export var max_speed :=450.0
export var drag_factor := 0.1

onready var aggro_area := $AggroArea
onready var raycast := $BatLook 

var velocity := Vector2.ZERO
var target: KinematicBody2D

func _ready() -> void:
	aggro_area.connect("body_entered", self, "_on_player_entered")
	aggro_area.connect("body_exited", self, "_on_player_exited")

func _physics_process(delta: float) -> void:
	# We start by calculating the bat's movement direction.
	var direction := Vector2.UP
	#var relative_cursor_position := get_local_mouse_position()
	# If the distance to the mouse is less than 500 pixels,
	#if relative_cursor_position.length() <500:
		# We convert the mouse's local position into a direction vector by
		# normalizing the position.
	#	direction = relative_cursor_position.normalized()
	if target:
		raycast.look_at(target.global_position)
		raycast.force_raycast_update()
		if raycast.get_collider() == target :
			direction = to_local(target.global_position).normalized()

	var desired_velocity = direction * max_speed
	var adjust = desired_velocity - velocity
	velocity += adjust * drag_factor
	velocity = move_and_slide(velocity, Vector2.DOWN)

func _on_player_entered(robot: KinematicBody2D) -> void:
	target = robot
	print("Entered")
	
func _on_player_exited(robot: KinematicBody2D) -> void:
	target = null
	print("Exited")
