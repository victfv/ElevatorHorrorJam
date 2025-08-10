extends Node3D

@export var vis_renderer: SubViewport
@export var outview_renderer: SubViewport
@export var view_blocker_main: MeshInstance3D
@export var view_blocker_shadow: MeshInstance3D

func _ready() -> void:
	view_blocker_main.material_override.set_shader_parameter("shadows", vis_renderer.get_texture())
	view_blocker_main.material_override.set_shader_parameter("shadow_view", outview_renderer.get_texture())
