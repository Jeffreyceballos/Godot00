extends Area2D

onready var open_chest = $AnimationPlayer

func _ready()-> void:
	connect("area_entered", self, "_on_chest_area_entered")
	connect("area_exited", self, "_on_chest_area_exited")

	
func _on_chest_area_entered(_body: PhysicsBody2D) -> void:
	open_chest.play("chest_open")

func _on_chest_area_exited(_body: PhysicsBody2D) -> void:
	open_chest.play_backwards("chest_open")
