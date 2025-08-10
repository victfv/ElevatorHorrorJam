extends TextureRect

@export var elevator : Node3D
@export var player : Player
@export var parent : Control
const hpi : float = PI/2.0
func _process(delta: float) -> void:
	position = (parent.size / 2.0) - Vector2(32,32)
	var vector := elevator.global_position - player.global_position
	var dir := Vector2(vector.x,vector.z).angle() + hpi
	rotation = lerp_angle(rotation, dir, delta * 3.0)
