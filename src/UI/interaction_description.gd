extends Label

@export var interaction : InteractionRay
@export var camera : Camera3D
func _process(delta: float) -> void:
	if interaction.current_col is InteractionArea or interaction.current_col is PanelInteractable:
		global_position = camera.unproject_position(interaction.current_col.global_position) - size * 0.5
		text = interaction.current_col.description
	else:
		text = ""
	pass
