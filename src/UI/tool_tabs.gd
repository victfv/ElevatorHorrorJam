extends TabContainer

class_name ToolTabs

enum {FLASHLIGHT = 2, PAPER = 1, EMF = 0}

func set_tool(tool : int) -> void:
	current_tab = tool
