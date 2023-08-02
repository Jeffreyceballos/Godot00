extends Sprite

var velocity := Vector2(50,0)

func _process(delta: float) -> void:
	position += velocity*delta
