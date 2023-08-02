extends PanelContainer


#var scores_column: Node
#
#func _ready() -> void:
#	scores_column = #$MarginContainer2/VBoxContainer/ScoresC#olumn

# waits for child nodes to be ready before assigning value
#accomplishes same as code above
onready var scores_column := $MarginContainer2/VBoxContainer/ScoresColumn

func _ready() -> void:
	add_row("Athos")
	add_row("Porthos")
	add_row("Aramis")

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
	
func add_row(player_name: String) -> void:
	var row := Label.new()
	row.text = player_name
	scores_column.add_child(row)


func _on_HideButton_pressed() -> void:
	hide()
