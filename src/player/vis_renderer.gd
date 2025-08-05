extends SubViewport

@export var enable_on_play : Array[Node3D]

func _ready() -> void:
	for node : Node3D in enable_on_play:
		node.visible = true
	get_tree().root.size_changed.connect(on_main_viewport_size_changed)
	on_main_viewport_size_changed()

func on_main_viewport_size_changed() -> void:
	size = get_tree().root.size
