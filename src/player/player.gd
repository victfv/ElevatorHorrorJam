extends RigidBody3D

class_name Player

@export var input_receiver: InputReceiver
@export var camera : Camera3D

var acceleration : float = 92.0
var damping : float = 16.0

var frozen : bool = false
func _physics_process(delta: float) -> void:
	if !frozen:
		var dir : Vector3 = input_receiver.udlr.x * camera.global_basis.x + input_receiver.udlr.y * camera.global_basis.y
		dir = dir.limit_length()
		apply_central_impulse(delta * acceleration * dir)
