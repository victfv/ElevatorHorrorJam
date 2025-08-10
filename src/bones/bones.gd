extends Node3D


@export var ritual : String
@export var fire: MeshInstance3D
@export var fire_light: OmniLight3D
@export var burn_curve : Curve
@export var time_to_burn : float = 3.0
@export var gradient_ramp : Texture2D
@export var interaction_area: InteractionArea

var burn_time : float = 3.0
var mat : ShaderMaterial
func _ready() -> void:
	set_process(false)
	var ritual_obj : Ritual = RitualLibrary.get_ritual(ritual)
	if ritual_obj.bones_burned or !ritual_obj.complete:
		visible = false
		interaction_area.enabled = false
		return
	mat = fire.material_override
	mat.set_shader_parameter("ramp", gradient_ramp)
	mat = fire.material_override
	burn_time = time_to_burn
	set_process(false)

func on_interacted(state : bool, player : Player) -> Node3D:
	if !burning:
		burning = true
		burn()
	return null

func burn() -> void:
	fire.visible = true
	set_process(true)

signal burnt
var burning : bool = false
func _process(delta: float) -> void:
	burn_time = max(0.0, burn_time - delta)
	mat.set_shader_parameter("emission_strength", burn_curve.sample_baked(burn_time / time_to_burn) * 1.0)
	fire_light.light_energy = burn_curve.sample_baked(burn_time / time_to_burn) * 3.0
	if burn_time < 0.001:
		fire.visible = false
		burnt.emit
		var ritual_obj : Ritual = RitualLibrary.get_ritual(ritual)
		ritual_obj.bones_done_burning()
		visible = false
		interaction_area.enabled = false
		set_process(false)
