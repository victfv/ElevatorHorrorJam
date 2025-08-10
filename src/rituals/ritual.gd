extends Node

class_name Ritual

@export var steps : Dictionary[String, bool]

var complete : bool = false
var bones_burned : bool = false
func _ready() -> void:
	RitualLibrary.register_ritual(self)

signal step_complete(step : String)
func complete_step(step : String) -> void:
	if steps.has(step):
		steps[step] = true
		step_complete.emit(step)
	for st : bool in steps.values():
		if !st:
			return
	complete = true
	ritual_completed.emit()

func undo_step(step : String) -> void:
	if steps.has(step):
		steps[step] = false

func is_step_completed(step : String) -> bool:
	return steps.get(step, false)

func bones_done_burning() -> void:
	bones_burned = true
	ritual_bones_burned.emit()

func get_step_complete(step : String) -> bool:
	return steps.get(step, false)

signal ritual_completed
signal ritual_bones_burned
