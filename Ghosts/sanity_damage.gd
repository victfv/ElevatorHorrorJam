extends Area3D

@export var ghost: Ghost

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	if player and ghost.visible:
		player.decrease_sanity(0.15 * delta)

var player : Player
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		player = body
		set_physics_process(true)


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		player = null
		set_physics_process(false)
