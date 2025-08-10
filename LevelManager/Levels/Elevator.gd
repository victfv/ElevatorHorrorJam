extends Node3D
class_name Elevator

@export var cover: ElevatorCover

func close_Door ():
	$AnimationPlayer.play("door_close")
	cover.fade_in()
	await $AnimationPlayer.animation_finished

func open_Door ():
	$AnimationPlayer.play("door_open")
	cover.fade_out()
	await $AnimationPlayer.animation_finished
