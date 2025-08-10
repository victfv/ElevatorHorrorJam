extends Node

var input_queue : Array[InputReceiver]
var mouse_mode : bool = true
var last_mouse_pos : Vector2
var last_rec : InputReceiver
func _physics_process(delta: float) -> void:
	if input_queue.size() > 0:
		var receiver : InputReceiver = input_queue[0]
		if last_rec and last_rec != receiver:
			last_rec.reset()
		receiver.udlr = Input.get_vector("LEFT","RIGHT","DOWN","UP",0.2)
		var size : Vector2 = get_tree().root.size
		var mouse_pos : Vector2 = get_tree().root.get_mouse_position()
		var controller_look : Vector2 = Input.get_vector("LOOK_LEFT","LOOK_RIGHT","LOOK_UP","LOOK_DOWN",0.2)
		if mouse_mode:
			receiver.l_udlr = (mouse_pos - (size * 0.5)).normalized()
			if controller_look.length_squared() > 0.25:
				mouse_mode = false
		else:
			if controller_look.length_squared() > 0.25:
				receiver.l_udlr = controller_look
			if mouse_pos.distance_squared_to(last_mouse_pos) > 16:
				mouse_mode = true
		
		if Input.is_action_just_pressed("ACTION"):
			receiver.action.emit(true)
		elif Input.is_action_just_released("ACTION"):
			receiver.action.emit(false)
		
		if Input.is_action_just_pressed("TOOL_UP"):
			receiver.change_tool.emit(1)
		if Input.is_action_just_pressed("TOOL_DOWN"):
			receiver.change_tool.emit(-1)
		
		if Input.is_action_just_pressed("PAUSE"):
			receiver.pause.emit()
		
		last_mouse_pos = mouse_pos
		last_rec = receiver

func register_receiver(rec : InputReceiver) -> void:
	if rec in input_queue:
		input_queue.erase(rec)
	input_queue.push_front(rec)

func unregister_receiver(rec : InputReceiver) -> void:
	if rec in input_queue:
		input_queue.erase(rec)
	input_queue.erase(rec)
