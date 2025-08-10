@tool
extends Area3D

class_name EMFArea

@export var range : float = 10.0
@export var shape : CollisionShape3D

func _ready() -> void:
	shape.shape.radius = range

func _on_area_entered(area: Area3D) -> void:
	if area is EMFDetector:
		area.register_area(self)

func _on_area_exited(area: Area3D) -> void:
	if area is EMFDetector:
		area.unregister_area(self)
