extends Area3D
class_name PanelInteractable

@export var panelUI : NumpadUI

func on_interacted(state : bool, player : Player) -> Node3D:
	panelUI.visible = true
	return
