extends Area3D

class_name InteractionArea
@export var description : String
@export var enabled : bool = true :
	set(en):
		enabled = en
		collision_layer = 0 if !enabled else 8
@export var call : Node3D
func _ready() -> void:
	collision_layer = 0 if !enabled else 8

func on_interacted(state : bool, player : Player) -> Node3D:
	if !enabled:
		return
	if call and call.has_method("on_interacted"):
		return call.on_interacted(state, player)
	return null
