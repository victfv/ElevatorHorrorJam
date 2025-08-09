extends Node

class_name Ritual

@export var steps : Dictionary[String, bool]

var complete : bool = false

func _ready() -> void:
	RitualLibrary.register_ritual(self)

func complete_step(step : String) -> void:
	if steps.has(step):
		steps[step] = true
	
	for st : bool in steps.keys():
		if !st:
			return
	complete = true
	ritual_completed.emit()

func undo_step(step : String) -> void:
	if steps.has(step):
		steps[step] = false

func is_step_completed(step : String) -> bool:
	return steps.get(step, false)

signal ritual_completed
