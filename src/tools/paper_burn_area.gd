extends Area3D

class_name PaperBurnArea

@export var color : Color = Color.WHITE
@export var strong : bool = false


func _on_area_entered(area: Area3D) -> void:
	if area is EMFDetector:
		area.burn_paper(strong, color)


func _on_area_exited(area: Area3D) -> void:
	if area is EMFDetector:
		area.stop_burn()
