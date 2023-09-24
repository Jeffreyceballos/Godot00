extends Area2D


onready var timer := $Timer
onready var light := $Light
onready var animation_player := $AnimationPlayer

func _ready() -> void:
	timer.connect("timeout", self, "_on_Timer_timeout")
	# Connect the body_entered signal to the _on_body_entered() function
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body: Node) -> void:
	animation_player.play("turn_on")
	# Set light.enabled to true to turn on the lights and start the timer
	# to turn off the lights after it counts down.
	timer.start()
	light.enabled = true
	pass


func _on_Timer_timeout() -> void:
	animation_player.play("turn_off")
	light.enabled = false
