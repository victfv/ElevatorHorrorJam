extends Control

class_name EMF_UI
@onready var emf_progress: ProgressBar = $HBoxContainer/EMFProgress

func set_strength(strength : float) -> void:
	emf_progress.value = clamp(strength,0,1)
