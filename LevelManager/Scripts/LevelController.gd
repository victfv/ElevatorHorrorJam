extends Node3D
class_name LevelController

@export var elevator : Elevator
@export var floorController : FloorController
@export var numpad : NumpadUI
@export var panel: PanelInteractable

func go_to_floor(floor_number: int) -> void:
	# Start coroutine
	if !floorController.check_floor(floor_number):
		return
	numpad.visible = false
	await elevator.close_Door()
	floorController.unload_floor()
	floorController.load_floor(floor_number)
	await get_tree().create_timer(2.0).timeout
	await elevator.open_Door()
	panel.enable()
