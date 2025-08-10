extends RayCast3D

class_name InteractionRay

@export var player : Player
var lock : Node3D = null
var current_col : Node3D = null
func interact(state : bool) -> void:
	var col : Node3D = get_collider()
	if lock:
		lock = lock.on_interacted(state, player)
	elif col and col.has_method("on_interacted"):
		lock = col.on_interacted(state, player)

func _physics_process(delta: float) -> void:
	if !lock:
		current_col = get_collider()
