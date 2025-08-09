extends Node

class_name RitualStep
@export var ritual_name : String
@export var step : String

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

func complete() -> void:
	if ritual:
		ritual.complete_step(step)
