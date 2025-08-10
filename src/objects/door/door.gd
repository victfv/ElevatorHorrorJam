extends Node3D

class_name Door

@export var locked : bool = false :
	set(lk):
		locked = lk
		if is_inside_tree():
			door_phys.freeze = locked
@export var door_phys: RigidBody3D

func _ready() -> void:
	set_physics_process(false)
	door_phys.freeze = locked

const hpi : float = PI/2.0
func _physics_process(delta: float) -> void:
	door_phys.rotation.y = clamp(door_phys.rotation.y, -hpi, hpi)
	door_phys.position = Vector3()


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	set_physics_process(true)


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	set_physics_process(false)
