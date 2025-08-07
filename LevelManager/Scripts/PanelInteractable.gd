extends Area3D
class_name PanelInteractable

@export var panelUI : NumpadUI

func on_interacted():
	panelUI.visible = true
	return
