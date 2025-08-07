extends Generic6DOFJoint3D

class_name PlayerGrabber
@export var player : Node3D

var grab_node : Node3D
func grab(obj : DynamicObject) -> void:
	#print("grab")
	if obj:
		grab_node = obj
		global_position = grab_node.global_position
		global_rotation = grab_node.global_rotation
		node_a = get_path_to(player)
		node_b = get_path_to(grab_node)
		#print(node_a," ", node_b)

func release(obj : DynamicObject) -> void:
	if obj == grab_node:
		#grab_core_joint.node_a = NodePath()
		#grab_core_joint.node_b = NodePath()
		node_a = NodePath()
		node_b = NodePath()
		grab_node = null
