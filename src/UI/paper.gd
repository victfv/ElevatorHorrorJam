extends Control

class_name BurnPaper

@onready var paper: TextureRect = $Paper
@onready var burn_0: TextureRect = $Burn0
@onready var burn_1: TextureRect = $Burn1

func unburn() -> void:
	burn_0.visible = false
	burn_1.visible = false

func burn(color : Color, full : bool = false) -> void:
	burn_0.modulate = color
	burn_1.modulate = color
	burn_0.visible = !full
	burn_1.visible = full
