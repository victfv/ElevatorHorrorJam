extends Area3D
class_name PanelInteractable

@export var panelUI : NumpadUI
@export var collisionShape : CollisionShape3D

func on_interacted(state : bool, player : Player) -> Node3D:
	panelUI.visible = true
	disable()
	return

func disable():
	collisionShape.disabled = true

func enable():
	collisionShape.disabled = false
