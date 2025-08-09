extends RitualStep

##Completes step when the scene is loaded
func _ready() -> void:
	super()
	if !completed:
		complete()
