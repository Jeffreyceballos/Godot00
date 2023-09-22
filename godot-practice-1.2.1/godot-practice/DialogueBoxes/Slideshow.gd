extends Control

var slideshow_data := [
	{"text": "In this series, you'll code a slideshow.",
	"texture":preload("common/backgrounds/community_garden.jpg")},
	{"text": "You can use the techniques you'll see here for simple cut-scenes, linear conversations, and more.",
	"texture":preload("common/backgrounds/community_garden.jpg")},
	{"text": "What you'll see here isn't limited to conversations. You'll learn the basics behind any sequence of events.", "texture":preload("common/backgrounds/dani_bedroom.jpg")},
	{"text": 'We will build upon this series to later create a branching dialogue system, a sort of "choose your own adventure" toy.',
	"texture":preload("common/backgrounds/dani_bedroom.jpg")},
]

var current_slide_index := 0
var last_slide_index : = slideshow_data.size()-1 

onready var texture_rect := $VBoxContainer/TextureRect
onready var label := $VBoxContainer/Label
onready var button := $VBoxContainer/Button

onready var tween := $Tween

func _ready() -> void:
	show_slide(0)
	button.connect("pressed", self, "advance")

func show_slide(new_slide_index: int) -> void:
	current_slide_index = new_slide_index
	
	var current_slide_data: Dictionary = slideshow_data[current_slide_index]
	set_text(current_slide_data["text"])
	texture_rect.texture =current_slide_data["texture"]
	if current_slide_index == last_slide_index:
		button.text ="Quit"
	
func set_text(new_text: String) -> void:
	label.text = new_text
	var duration := new_text.length() / 60.0
	tween.interpolate_property(label, "percent_visible", 0.0, 1.0, duration)
	tween.start()

func advance() -> void:
	if tween.is_active():
		tween.seek(INF)
	else:
		if current_slide_index == last_slide_index:
			get_tree().quit()
		else:
			show_slide(current_slide_index + 1)
