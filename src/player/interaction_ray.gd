extends RayCast3D

class_name InteractionRay

@export var player : Player

func interact(state : bool) -> void:
	var col : Node3D = get_collider()
	if col and col.has_method("on_interacted"):
		col.on_interacted(state, player)
