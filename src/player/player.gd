extends RigidBody3D

class_name Player

@export var input_receiver: InputReceiver
@export var camera : Camera3D
@export var grabber: PlayerGrabber

var sanity : float = 1.0
var sanity_rec_delay : float = 0.0
func decrease_sanity(amount : float):
	sanity = max(0.0, sanity - amount)
	sanity_rec_delay = 2.5
	if sanity < 0.001:
		sanity = 0
		get_tree().change_scene_to_file("res://src/UI/Endings/die.tscn")

var acceleration : float = 800.0
var damping : float = 16.0

var frozen : bool = false
func _physics_process(delta: float) -> void:
	sanity_rec_delay = max(0.0, sanity_rec_delay - delta)
	if sanity_rec_delay < 0.001:
		sanity = min(1.0, sanity + 0.06 * delta)
	if !frozen:
		var dir : Vector3 = input_receiver.udlr.x * camera.global_basis.x + input_receiver.udlr.y * camera.global_basis.y
		dir = dir.limit_length()
		apply_central_impulse(delta * acceleration * dir)
