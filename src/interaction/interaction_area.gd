extends Area3D

class_name InteractionArea

@export var call : Node3D
func on_interacted(state : bool, player : Player) -> Node3D:
	if call and call.has_method("on_interacted"):
		return call.on_interacted(state, player)
	return null
