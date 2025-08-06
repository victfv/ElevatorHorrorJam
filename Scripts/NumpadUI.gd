extends Control
class_name NumpadUI
@export var display_label: Label
@export var levelController : LevelController

var current_input := ""

func _ready():
	# Connect all numpad button signals dynamically
	for child in $Panel/GridContainer.get_children():
		if child is Button:
			child.pressed.connect(_on_button_pressed.bind(child.text))
	$Panel/CloseButton.pressed.connect(_on_close_button_pressed)

func _on_button_pressed(button_text: String):
	match button_text:
		"Enter":
			_on_enter_pressed()
		"Erase":
			_on_erase_pressed()
		_:
			_on_digit_pressed(button_text)

func _on_digit_pressed(digit: String):
	if current_input.length() < 2:
		current_input += digit
		display_label.text = current_input

func _on_erase_pressed():
	if current_input.length() > 0:
		current_input = current_input.substr(0, current_input.length() - 1)
		display_label.text = current_input

func _on_enter_pressed():
	levelController.go_to_floor( int(current_input))
	current_input = ""
	display_label.text = ""

func _on_close_button_pressed():
	self.visible = false
