extends Area3D

class_name EMFDetector

@export var emf_ui : EMF_UI
@export var paper : BurnPaper
var emf_areas : Array[EMFArea]

func register_area(area : EMFArea) -> void:
	if !emf_areas.has(area):
		emf_areas.append(area)

func unregister_area(area : EMFArea) -> void:
	if emf_areas.has(area):
		emf_areas.erase(area)

var strength : float = 1.0
func _physics_process(delta: float) -> void:
	var n_strength : float = 1.0
	for area : EMFArea in emf_areas:
		var dist : float = (Vector2(global_position.x,global_position.z).distance_to(Vector2(area.global_position.x, area.global_position.z))) / area.range
		n_strength = min(n_strength, dist)
	
	strength = lerp(strength, n_strength + randf_range(-0.1,0.10), 4.0 * delta)
	
	emf_ui.set_strength(strength)

func burn_paper(strong : bool, color : Color) -> void:
	paper.burn(color, strong)

func stop_burn() -> void:
	paper.unburn()
