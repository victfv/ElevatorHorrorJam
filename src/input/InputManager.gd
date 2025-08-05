extends Node

var input_queue : Array[InputReceiver]
var mouse_mode : bool = true
func _physics_process(delta: float) -> void:
	if input_queue.size() > 0:
		var receiver : InputReceiver = input_queue[0]
		receiver.udlr = Input.get_vector("LEFT","RIGHT","DOWN","UP",0.2)
		var size : Vector2 = get_tree().root.size
		var mouse_pos : Vector2 = get_tree().root.get_mouse_position()
		receiver.l_udlr = (mouse_pos - (size * 0.5)).normalized()
		
		if Input.is_action_just_pressed("ACTION"):
			receiver.action.emit(true)
		elif Input.is_action_just_released("ACTION"):
			receiver.action.emit(false)

func register_receiver(rec : InputReceiver) -> void:
	if rec in input_queue:
		input_queue.erase(rec)
	input_queue.push_front(rec)

func unregister_receiver(rec : InputReceiver) -> void:
	if rec in input_queue:
		input_queue.erase(rec)
	input_queue.erase(rec)
