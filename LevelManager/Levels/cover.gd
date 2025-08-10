extends CSGBox3D

class_name ElevatorCover

func fade_in() -> void:
	material_override.albedo_color.a = 0.0
	visible = true
	create_tween().tween_property(material_override, "albedo_color:a", 1.0, 0.4)

func fade_out() -> void:
	visible = true
	material_override.albedo_color.a = 1.0
	var tween := create_tween()
	tween.tween_property(material_override, "albedo_color:a", 0.0, 0.4)
	await tween.finished
	visible = false
