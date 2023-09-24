extends Node

onready var animation_player = $AnimationPlayer

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: Node) -> void:
	animation_player.play("destroy")
	apply_effect(body)

func apply_effect(_body: Node) -> void:
	pass
