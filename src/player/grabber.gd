extends Generic6DOFJoint3D

class_name PlayerGrabber
@export var player : Node3D
@export var rotator: PlayerRotator

var grab_node : Node3D

func grab(obj : DynamicObject) -> void:
	#print("grab")
	if obj:
		grab_node = obj
		#global_position = grab_node.global_position
		global_rotation = grab_node.global_rotation
		node_a = get_path_to(player)
		node_b = get_path_to(grab_node)
		rotator.speed = clamp(remap(grab_node.mass, 1.0, 50.0, 2.0, 0.25),0.5,6.0)
		#print(node_a," ", node_b)
		#call_deferred("set_physics_process",true)

func release(obj : DynamicObject) -> void:
	if obj == grab_node:
		#grab_core_joint.node_a = NodePath()
		#grab_core_joint.node_b = NodePath()
		node_a = NodePath()
		node_b = NodePath()
		rotator.speed = 6.0
		grab_node = null

#func _physics_process(delta: float) -> void:
	#if grab_node:
		#if player.global_position.distance_squared_to(global_position) > 0.25:
			#print(player.global_position.distance_squared_to(global_position))
			#print("released")
			#release(grab_node)
