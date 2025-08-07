@tool
extends GridMap

@export_tool_button("Convert") var conv : Callable = convert_gridmap
@export var auto_convert : bool = false
@export_flags_3d_render var visibility_layers : int = 1
func _ready() -> void:
	if auto_convert and !Engine.is_editor_hint():
		visible = false
		await get_tree().process_frame
		await get_tree().process_frame
		convert_gridmap()

func convert_gridmap() -> void:
	var meshes : Dictionary[Mesh, Array]
	var mesh_array := get_meshes()
	
	for i in range(mesh_array.size() / 2):
		var current_mesh : Mesh = mesh_array[i * 2 + 1]
		var current_transform : Transform3D = mesh_array[i * 2]
		if meshes.has(current_mesh):
			meshes[current_mesh].append(current_transform)
		else:
			meshes[current_mesh] = [current_transform]
	
	var outer_parent : Node3D = Node3D.new()
	outer_parent.name = name + " Bake"
	get_parent().add_child(outer_parent)
	outer_parent.global_transform = global_transform
	if Engine.is_editor_hint():
		outer_parent.owner = get_tree().edited_scene_root
	for mesh : Mesh in meshes.keys():
		var octants : Dictionary[Vector3i, Array]
		for ttrs : Transform3D in meshes[mesh]:
			var trs : Transform3D = global_transform * ttrs
			var octant : Vector3i = Vector3i(trs.origin.x / 8.0, trs.origin.y / 8.0, trs.origin.z / 8.0)
			if octants.has(octant):
				octants[octant].append(trs)
			else:
				octants[octant] = [trs]
		for octant : Vector3i in octants.keys():
			var instance : MultiMeshInstance3D = MultiMeshInstance3D.new()
			outer_parent.add_child(instance)
			var multimesh : MultiMesh = MultiMesh.new()
			multimesh.mesh = mesh
			multimesh.transform_format = MultiMesh.TRANSFORM_3D
			multimesh.instance_count = octants[octant].size()
			instance.multimesh = multimesh
			instance.layers = visibility_layers
			instance.position = Vector3()
			if Engine.is_editor_hint():
				instance.owner = get_tree().edited_scene_root
			var trss : Array = octants[octant]
			for i : int in range(trss.size()):
				multimesh.set_instance_transform(i, instance.global_transform.inverse() * trss[i])
