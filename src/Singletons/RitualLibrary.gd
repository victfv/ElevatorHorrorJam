extends Node

var rituals : Dictionary[String, Ritual]

func register_ritual(ritual : Ritual) -> void:
	rituals[ritual.name] = ritual

func get_ritual(ritual_name : String) -> Ritual:
	return rituals.get(ritual_name, null)
