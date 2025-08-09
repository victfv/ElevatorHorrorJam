extends Node3D

class_name PlayerRotator
@export var player : Player
@export var input_receiver: InputReceiver
@export var head: Node3D

const hpi : float = PI / 2.0
func _physics_process(delta: float) -> void:
	player.global_rotation.y = lerp_angle(player.global_rotation.y,-input_receiver.l_udlr.angle() - hpi,delta * 6.0)
	head.global_rotation.y = lerp_angle(head.global_rotation.y,-input_receiver.l_udlr.angle() - hpi,delta * 16.0)
	#print(head.rotation.y)
	head.rotation.y = clampf(head.rotation.y, -hpi, hpi)
