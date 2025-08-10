extends Control


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://src/UI/Menu/main_menu.tscn")

func _on_input_receiver_action(state: bool) -> void:
	get_tree().change_scene_to_file("res://src/UI/Menu/main_menu.tscn")
