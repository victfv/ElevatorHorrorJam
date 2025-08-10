extends Node

class_name InputReceiver

@export var auto_register : bool = false

var udlr : Vector2
var l_udlr : Vector2

signal action(state : bool)
signal change_tool(dir : int)

func _ready() -> void:
	if auto_register:
		register()

func register() ->void:
	InputManager.register_receiver(self)

func unregister() -> void:
	InputManager.unregister_receiver(self)
