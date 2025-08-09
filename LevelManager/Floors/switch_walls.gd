extends Node3D

@export var vis_notifier: VisibleOnScreenNotifier3D
@export var walls : Array[CSGShape3D]

func _ready() -> void:
	vis_notifier.screen_entered.connect(screen_entered)
	vis_notifier.screen_exited.connect(screen_exited)

func screen_entered() -> void:
	pass

func screen_exited() -> void:
	print("switch")
	switch()

func switch() -> void:
	for wall : CSGShape3D in walls:
		if randi() % 2 == 0:
			wall.visible = false
			wall.collision_layer = 0
		else:
			wall.visible = true
			wall.collision_layer = 1
