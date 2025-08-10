extends Node

@export var tool_tabs: ToolTabs
@export var flashlight: SpotLight3D

enum {FLASHLIGHT = 2, PAPER = 1, EMF = 0}

var tool : int = FLASHLIGHT
func _on_input_receiver_change_tool(dir: int) -> void:
	tool += dir
	tool = tool if tool <= 2 else 0
	tool = tool if tool >= 0 else 2
	tool_tabs.set_tool(tool)
	
	match tool:
		FLASHLIGHT:
			flashlight.visible = true
		PAPER:
			flashlight.visible = false
		EMF:
			flashlight.visible = false
