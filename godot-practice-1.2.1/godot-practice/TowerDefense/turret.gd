extends Area2D
export (float, 0.01, 1.0) var rotation_factor := 0.1

onready var timer = $Timer
onready var cannon = $Sprite/Position2D
onready var sprite = $Sprite

var target: PhysicsBody2D = null

var target_list := []

func _ready() -> void:
	timer.connect("timeout", self, "_on_Timer_timeout")
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	
func _on_Timer_timeout() -> void:
	if not target_list:
		return
	var rocket: Area2D = preload("common/Rocket.tscn").instance()
	add_child(rocket)
	rocket.global_transform = cannon.global_transform

func select_target() -> void:
	if target_list:
		target = target_list[0]
	else:
		target = null
	
func _on_body_entered(body: Node) -> void:
	print("Entered\n")
	target_list.append(body)
	#target = target_list[0]
	select_target()
	
func _on_body_exited(body: Node) -> void:
	print("Exited\n")
	var index:= target_list.find(body)
	target_list.remove(index)
	
	#if target_list:
	#	target = target_list[0]
	#else:
	#	target = null
	select_target()

func _physics_process(_delta: float) -> void:
	_rotate_to_target()
	
func _rotate_to_target() -> void:
	var target_angle := PI / 2.0
	if target:
		target_angle = target.global_position.angle_to_point(global_position)
	sprite.rotation = lerp_angle(sprite.rotation, target_angle, rotation_factor)
