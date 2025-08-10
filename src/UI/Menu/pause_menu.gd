extends Control

@export var quit: Button
@export var input_receiver: InputReceiver
@export var resume: Button

func _ready() -> void:
	if OS.get_name() == "Web":
		quit.visible = false

func _process(delta: float) -> void:
	pass

func open() -> void:
	get_tree().paused = true
	show()
	resume.grab_focus()
	await get_tree().process_frame
	await get_tree().process_frame
	input_receiver.register()

func close() -> void:
	hide()
	get_tree().paused = false

func _on_resume_pressed() -> void:
	close()
	await get_tree().process_frame
	await get_tree().process_frame
	input_receiver.unregister()


func _on_quit_pressed() -> void:
	get_tree().quit()
