class_name Book
extends Resource

export(Array, String) var lines := []

func get_random_line() -> String:
	var rand_int = randi() % lines.size()
	return lines[rand_int]
