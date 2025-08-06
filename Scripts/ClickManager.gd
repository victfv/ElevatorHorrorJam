extends Node3D
class_name ClickManager
@export var camera: Camera3D
@export var ui_panel: Control
@export var panel_target: Node3D  # The 3D object with collision
@export var collision_mask: int = 0xFFFFFFFF

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = event.position
		var space_state = get_world_3d().direct_space_state

		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_direction = camera.project_ray_normal(mouse_pos)
		var ray_target = ray_origin + ray_direction * 100.0
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_target, collision_mask)
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)

		if result and result.has("collider") and result.collider == panel_target:
			show_ui()

func show_ui():
	ui_panel.visible = true

func hide_ui():
	ui_panel.visible = false
