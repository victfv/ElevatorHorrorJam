extends Node

var input_queue : Array[InputReceiver]

func _physics_process(delta: float) -> void:
	if input_queue.size() > 0:
		var receiver : InputReceiver = input_queue[0]
		receiver.udlr = Input.get_vector("LEFT","RIGHT","UP","DOWN",0.2)
		receiver.l_udlr
		
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
