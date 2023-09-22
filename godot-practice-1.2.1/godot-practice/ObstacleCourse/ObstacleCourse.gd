extends Node2D

onready var godot = $Course/Godot
onready var timer = $Timer
onready var ui_remaining_time = $CanvasLayer/RemainingTime
onready var finish_line = $FinishLine
onready var info_label = $CanvasLayer/Info

func _ready() -> void:
	godot.set_physics_process(false)
	ui_remaining_time.text = get_time_as_text(timer.wait_time)
	set_process(false)
	finish_line.connect("body_entered", self, "_on_finish_line_body_entered")
	timer.connect("timeout", self, "finish_game")

func start() -> void:
	godot.set_physics_process(true)
	timer.start()
	set_process(true)

func _process(delta: float) -> void:
	ui_remaining_time.text = get_time_as_text(timer.time_left)

func get_time_as_text(time: float) -> String:
	return str(time).pad_decimals(2).pad_zeros(2)

func _on_finish_line_body_entered(body : Node) -> void:
	finish_game()

func finish_game() -> void:
	set_process(false)
	godot.set_physics_process(false)
	info_label.rect_scale = Vector2.ONE
	info_label.get_font("font").size = 128
	info_label.show()
	info_label.text = "You lost!"
	if timer.time_left > 0.0 : 
		var player_time: float = timer.wait_time - timer.time_left
		info_label.text = "You won!\nTime: " + get_time_as_text(player_time)
	timer.stop()
