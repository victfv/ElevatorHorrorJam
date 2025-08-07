extends Node3D

class_name PlayerRotator
@export var input_receiver: InputReceiver

const hpi : float = PI / 2.0
func _physics_process(delta: float) -> void:
	rotation.y = -input_receiver.l_udlr.angle() - hpi
	pass
