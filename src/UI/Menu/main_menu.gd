extends Control

@onready var quit: Button = $Panel/CenterContainer/VBoxContainer/Quit
@onready var start: Button = $Panel/CenterContainer/VBoxContainer/Start

func _ready() -> void:
	start.grab_focus()
	if OS.get_name() == "Web":
		quit.visible = false


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://src/UI/Menu/begin_cutscene.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
