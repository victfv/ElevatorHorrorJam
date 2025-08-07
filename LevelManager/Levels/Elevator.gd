extends Node3D
class_name Elevator

func close_Door ():
	$AnimationPlayer.play("door_close")
	await $AnimationPlayer.animation_finished

func open_Door ():
	$AnimationPlayer.play("door_open")
	await $AnimationPlayer.animation_finished
