extends PanelContainer

onready var rich_text_label := $MarginContainer/VBoxContainer/HBoxContainer/RichTextLabel

onready var buttons_column := $MarginContainer/VBoxContainer/ButtonsColumn

onready var texture_rect := $MarginContainer/VBoxContainer/HBoxContainer/TextureRect

onready var tween := $Tween

onready var audio_player := $AudioStreamPlayer

var dialogue = {
	0: {
		"text": "Hey, [i]wake up![/i] It's time to make video games.",
		"expression": "neutral",
		"buttons":
		{
			"Let me sleep a little longer": 2,
			"Let's do it!": 1,
		}
	},
	1: {
		"text": "Great! Your first task will be to write a [b]dialogue tree[/b].",
		"expression": "neutral",
		"buttons":
		{
			"I'm not sure if I'm ready, but I will do my best": 3,
			"No, let me go back to sleep": 2,
		}
	},
	2: {
		"text": "Oh, come on! It'll be fun.",
		"expression": "sad",
		"buttons":
		{
			"No, really, let me go back to sleep": 0,
			"Alright, I'll try": 3,
		}
	},
	3: {
		"text": "That's the spirit! You can do it!\n[wave][b]YOU WIN[/b][/wave]",
		"expression": "happy",
		"buttons": {}
	}
}

func set_text(new_text: String) -> void:
	rich_text_label.bbcode_text = new_text
	var duration: float = rich_text_label.text.length()/60.0
	tween.interpolate_property(rich_text_label, "percent_visible", 0.0, 1.0, duration)
	tween.start()
	var sound_start_position: float = randf() * audio_player.stream.get_length()
	audio_player.play(sound_start_position)

func set_expression(expression: String) -> void:
	if expression == "sad":
		texture_rect.texture = preload("portraits/sophia_sad.png")
	elif expression == "happy":
		texture_rect.texture = preload("portraits/sophia_happy.png")
	else:
		preload("portraits/sophia_neutral.png")	

func create_buttons(buttons_data: Dictionary) -> void:
	for text in buttons_data:
		# add ned button
		var button := Button.new()
		button.text = text
		buttons_column.add_child(button)
		
		# grab the next button id
		var target_line_id: int = buttons_data[text]
		
		# add signal
		# when the button is pressed
		# it will call "show_line"
		# using value passed in array
		button.connect("pressed", self, "show_line", [target_line_id])

func add_quit_button() -> void:
	var quit_button := Button.new()
	quit_button.text = "Quit"
	buttons_column.add_child(quit_button)
	# We can directly connect a signal to a function or another object. Clicking
	# the button will call the scene tree's quit() function. 
	quit_button.connect("pressed", get_tree(), "quit")

func show_line(id: int) -> void:
	# get dialogue section
	var line_data: Dictionary = dialogue[id]
	
	# set dialogue text and pic
	set_text(line_data["text"])
	set_expression(line_data["expression"])
	
	# delete previous set of buttons
	for button in buttons_column.get_children():
		button.queue_free()
	
	# add new set of buttons if any
	if line_data["buttons"]:
		create_buttons(line_data["buttons"])
	else:
		# If the line has no buttons, we reached the dialogue's end, so we create a
		# single quit button.
		add_quit_button()
	
func _ready() -> void:
	show_line(0)
	tween.connect("tween_all_completed", audio_player, "stop")
