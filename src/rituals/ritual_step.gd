extends Node

class_name RitualStep
@export var ritual_name : String
@export var step : String
@export var requirements : Array[String]

var ritual : Ritual
var completed : bool = false
func _ready() -> void:
	ritual = RitualLibrary.get_ritual(ritual_name)
	if !ritual:
		printerr("Error: No ritual assigned!")
	elif ritual.is_step_completed(step):
		already_completed()

func already_completed() -> void: #Called when ritual is completed already
	completed = true

func undo() -> void:
	if ritual:
		ritual.undo_step(step)

func complete() -> bool:
	if ritual:
		var req_met : bool = true
		for stp : String in requirements:
			if !ritual.get_step_complete(stp):
				req_met = false
				break
		if req_met:
			ritual.complete_step(step)
			return true
	return false
