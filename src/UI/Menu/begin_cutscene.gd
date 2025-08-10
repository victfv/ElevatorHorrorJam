extends Control

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ACTION"):
		get_tree().change_scene_to_file("res://LevelManager/Levels/main_level.tscn")
