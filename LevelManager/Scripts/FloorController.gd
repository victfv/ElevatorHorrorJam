extends Node3D
class_name FloorController
# Folder where your floor scenes are located
@export var floor_scene_path_base: String = "res://Floors/Floor"
@export var floor_scenes: Dictionary  # key: int, value: PackedScene

@export var current_floor_instance: Node = null

func check_floor (floor_number: int) -> bool: 
	if floor_scenes.has(floor_number):
		return true
	return false

func unload_floor():
	# Unload current floor
	if current_floor_instance:
		current_floor_instance.queue_free()
		current_floor_instance = null

func load_floor(floor_number: int):
	# Unload current floor
	if current_floor_instance:
		current_floor_instance.queue_free()
		current_floor_instance = null

	# Get the scene from the dictionary
	if not floor_scenes.has(floor_number):
		push_error("Floor not found in dictionary: %d" % floor_number)
		return

	var scene: PackedScene = floor_scenes[floor_number]
	current_floor_instance = scene.instantiate()
	add_child(current_floor_instance)
