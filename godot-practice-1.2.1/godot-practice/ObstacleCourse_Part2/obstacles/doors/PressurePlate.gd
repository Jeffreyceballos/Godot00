# By convention, we place the tool keyword at the top of the script, before the
# extends line.
tool
extends Area2D

export(float, 0.0, 100) var open_time := 1.0

onready var timer := $Timer
onready var line := $Line2D
onready var door := $Door
onready var animation_player := $AnimationPlayer
onready var door_animation := $Door/AnimationPlayer

#onready var door_mask = door.collision_mask
#onready var door_layer = door.collision_layer

func _ready() -> void:
	connect("body_entered", self, "_on_PressurePlate_body_entered")
	connect("body_exited", self, "_on_PressurePlate_body_exited")
	timer.connect("timeout", self, "close_door")
	
	timer.wait_time = open_time
	line.points = [
		Vector2.ZERO,
		Vector2(door.position.x, 0.0),
		door.position
	]

func _on_PressurePlate_body_entered (_body: Node) -> void:
	timer.wait_time = open_time
	timer.stop()
	print ("ENTERED : waiting, time = " + str(timer.wait_time))
	animation_player.play("open")
	door_animation.play("open")
	pass

func _on_PressurePlate_body_exited (_body: Node) -> void:
	timer.start()
	print("starting")
	pass

func close_door() -> void:
	print("closing")
	animation_player.play("closed")
	door_animation.play("closed")
	pass

func _get_configuration_warning() -> String:
	var door_node := get_node_or_null("Door") as StaticBody2D
	if not door_node:
		return "This node needs a child node named Door, either an instance of DoorHorizontal or DoorVertical."
	return ""
