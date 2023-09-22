extends PanelContainer

var player_scores = {
	"Scrooge McDuck": 99999,
	"Magicka De Spell": 700,
	"Gyro Gearloose": 200,
	"Daisy Duck": 120,
	"Great Gatsby" : 50,
}

#var scores_column: Node
#
#func _ready() -> void:
#	scores_column = #$MarginContainer2/VBoxContainer/ScoresColumn

# waits for child nodes to be ready before assigning value
#accomplishes same as code above
onready var scores_column := $MarginContainer2/VBoxContainer/ScoresColumn

func _ready() -> void:
	for name in player_scores:
		add_row(name, str(player_scores[name]))


#func _ready() -> void:
	#add_row("Athos")
	#add_row("Porthos")
	#add_row("Aramis")

func add_label(text: String) -> void:
	var label := Label.new()
	label.text = text
	# This call adds the label as a child of the node with this script attached.
	add_child(label)

func add_timer(duration: float) -> void:
	# We create a new Timer node.
	var timer := Timer.new()
	# We set the timer to last duration seconds and not cycle.
	timer.wait_time = duration
	timer.one_shot = true
	# And we add it as a child of the node with the script attached.
	add_child(timer)
	
func add_row(player_name: String, player_points: String) -> void:
	#var row := Label.new()
	#row.text = player_name
	#scores_column.add_child(row)
	
	# Loads the ScoreRow scene and creates a new instance of it.
	var row := preload("ScoreRow.tscn").instance()
	
	# We can add the ScoreRow instance as a child of the ScoresColumn like
	# plain nodes.
	scores_column.add_child(row)
	
	# As we instanced the ScoreRow scene, we can call the functions we defined
	# on it.

	row.set_player_points(player_points)
	row.set_player_name(player_name)
	
	# If there's a key matching player_name in the dictionary, this line will
	# update the corresponding score. If there's no key matching player_name, it
	# will add an entry to the player_scores dictionary.
	
	player_scores[player_name] = player_points


func _on_HideButton_pressed() -> void:
	hide()
