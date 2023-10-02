class_name CharacterStats
extends Resource

export var strength := 5
export var endurance := 5
export var intelligence := 5

func save() ->void:
	ResourceSaver.save(resource_path, self)
