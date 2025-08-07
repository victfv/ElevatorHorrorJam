@tool
extends EditorPlugin

var gridmap_button: Button
var checkbox: CheckBox
var multimesh_button: Button
var separate_children_checkbox: CheckBox
var multimesh_to_gridmap_button: Button  # New button
var container: HBoxContainer

func _enter_tree():
	
	# Create a container to hold the buttons and checkboxes
	container = HBoxContainer.new()
	container.name = "GridMapConverterContainer"
	
	# Create the GridMap convert button
	gridmap_button = Button.new()
	gridmap_button.text = "Convert GridMap to Scene"
	gridmap_button.pressed.connect(_on_gridmap_button_pressed)
	
	# Create the checkbox for MultiMesh option
	checkbox = CheckBox.new()
	checkbox.text = "Use MultiMesh"
	checkbox.tooltip_text = "Enable to combine identical meshes into MultiMeshInstance3D nodes"
	
	# Create the MultiMesh convert button
	multimesh_button = Button.new()
	multimesh_button.text = "Convert Node to MultiMesh"
	multimesh_button.pressed.connect(_on_multimesh_button_pressed)
	
	# Create the Separate Children checkbox
	separate_children_checkbox = CheckBox.new()
	separate_children_checkbox.text = "Separate Children"
	separate_children_checkbox.tooltip_text = "Enable to process child nodes separately during MultiMesh conversion"
	
	# Create the MultiMesh to GridMap convert button
	multimesh_to_gridmap_button = Button.new()
	multimesh_to_gridmap_button.text = "Convert MultiMesh to GridMap"
	multimesh_to_gridmap_button.pressed.connect(_on_multimesh_to_gridmap_button_pressed)
	
	# Add to container
	container.add_child(gridmap_button)
	container.add_child(checkbox)
	container.add_child(multimesh_button)
	container.add_child(separate_children_checkbox)
	container.add_child(multimesh_to_gridmap_button)
	
	# Add container to toolbar
	add_control_to_container(CONTAINER_TOOLBAR, container)
	container.show()  # Temporarily show for testing
	
	
	# Connect to selection changes
	var selection = get_editor_interface().get_selection()
	if selection:
		selection.selection_changed.connect(_on_selection_changed)
		
	else:
		push_warning("Failed to get EditorSelection")
	
	# Check initial selection
	_on_selection_changed()
	

func _exit_tree():
	
	# Disconnect selection changed signal
	var selection = get_editor_interface().get_selection()
	if selection and selection.selection_changed.is_connected(_on_selection_changed):
		selection.selection_changed.disconnect(_on_selection_changed)
		
	
	# Remove and free the container
	remove_control_from_container(CONTAINER_TOOLBAR, container)
	container.queue_free()
	

func _on_selection_changed():
	var selection = get_editor_interface().get_selection()
	var selected_nodes = selection.get_selected_nodes()
	
	
	if selected_nodes.size() == 1:
		var selected_node = selected_nodes[0]
	
		if selected_node is GridMap:
			
			gridmap_button.show()
			checkbox.show()
			multimesh_button.hide()
			separate_children_checkbox.hide()
			multimesh_to_gridmap_button.hide()
			container.show()
		elif selected_node is MultiMeshInstance3D or _has_multimesh_instances(selected_node):
			
			gridmap_button.hide()
			checkbox.hide()
			multimesh_button.hide()
			separate_children_checkbox.hide()
			multimesh_to_gridmap_button.show()
			container.show()
		elif _has_mesh_instances(selected_node):
		
			gridmap_button.hide()
			checkbox.hide()
			multimesh_button.show()
			separate_children_checkbox.show()
			multimesh_to_gridmap_button.hide()
			container.show()
		else:
			
			container.hide()
	else:

		container.hide()

func _has_mesh_instances(node: Node) -> bool:
	if node is MeshInstance3D:
		
		return true
	for child in node.get_children():
		if _has_mesh_instances(child):
			return true
	return false

func _has_multimesh_instances(node: Node) -> bool:
	if node is MultiMeshInstance3D:
		
		return true
	for child in node.get_children():
		if _has_multimesh_instances(child):
			return true
	return false

func _on_gridmap_button_pressed():
	# [Your existing _on_gridmap_button_pressed code]
	var selection = get_editor_interface().get_selection()
	var selected_nodes = selection.get_selected_nodes()

	if selected_nodes.size() == 0:
		show_error("No node selected. Please select a GridMap node.")
		return

	var selected_node = selected_nodes[0]
	if not selected_node is GridMap:
		show_error("Selected node is not a GridMap. Please select a GridMap node.")
		return

	var converter = load("res://addons/gridmap-converter/converter.gd").new()
	if not converter.has_method("convert"):
		show_error("Converter script is missing the 'convert' method.")
		return

	var use_multimesh = checkbox.button_pressed
	var converted_node = converter.convert(selected_node, use_multimesh)
	if converted_node == null:
		show_error("Conversion failed: 'convert' returned null.")
		return

	var root = get_editor_interface().get_edited_scene_root()
	if root == null:
		show_error("No scene root found. Please open a scene.")
		return



	# Add the node to the scene
	root.add_child(converted_node)
	converted_node.owner = root  # Set owner for editor visibility

	# Set owner for all children recursively
	set_owners_recursive(converted_node, root)

	# Refresh the editor and select the new node
	get_editor_interface().get_selection().clear()
	get_editor_interface().get_selection().add_node(converted_node)
	get_editor_interface().mark_scene_as_unsaved()  # Mark scene as modified
	

func _on_multimesh_button_pressed():
	# [Your existing _on_multimesh_button_pressed code]
	var selection = get_editor_interface().get_selection()
	var selected_nodes = selection.get_selected_nodes()

	if selected_nodes.size() == 0:
		show_error("No node selected. Please select a node with MeshInstance3D children.")
		return

	var selected_node = selected_nodes[0]
	if not _has_mesh_instances(selected_node):
		show_error("Selected node has no MeshInstance3D children.")
		return

	var converter = load("res://addons/gridmap-converter/converter.gd").new()
	if not converter.has_method("convert_node_to_multimesh"):
		show_error("Converter script is missing the 'convert_node_to_multimesh' method.")
		return

	var converted_node = converter.convert_node_to_multimesh(selected_node, separate_children_checkbox.button_pressed)
	if converted_node == null:
		show_error("Conversion failed: 'convert_node_to_multimesh' returned null.")
		return

	var root = get_editor_interface().get_edited_scene_root()
	if root == null:
		show_error("No scene root found. Please open a scene.")
		return


	# Add the node to the scene
	root.add_child(converted_node)
	converted_node.owner = root  # Set owner for editor visibility

	# Set owner for all children recursively
	set_owners_recursive(converted_node, root)

	# Refresh the editor and select the new node
	get_editor_interface().get_selection().clear()
	get_editor_interface().get_selection().add_node(converted_node)
	get_editor_interface().mark_scene_as_unsaved()  # Mark scene as modified
	

	# Move camera to the converted node for visibility
	get_editor_interface().get_editor_viewport_3d(0).set_camera_position(converted_node.global_transform.origin)

func _on_multimesh_to_gridmap_button_pressed():
	var selection = get_editor_interface().get_selection()
	var selected_nodes = selection.get_selected_nodes()

	if selected_nodes.size() == 0:
		show_error("No node selected. Please select a node with MultiMeshInstance3D children.")
		return

	var selected_node = selected_nodes[0]
	if not _has_multimesh_instances(selected_node):
		show_error("Selected node has no MultiMeshInstance3D children.")
		return

	var converter = load("res://addons/gridmap-converter/converter.gd").new()
	if not converter.has_method("convert_multimesh_to_gridmap"):
		show_error("Converter script is missing the 'convert_multimesh_to_gridmap' method.")
		return

	# Optionally, allow the user to specify a MeshLibrary (e.g., via a file dialog or editor property)
	var converted_node = converter.convert_multimesh_to_gridmap(selected_node)
	if converted_node == null:
		show_error("Conversion failed: 'convert_multimesh_to_gridmap' returned null.")
		return

	var root = get_editor_interface().get_edited_scene_root()
	if root == null:
		show_error("No scene root found. Please open a scene.")
		return



	# Add the node to the scene
	root.add_child(converted_node)
	converted_node.owner = root  # Set owner for editor visibility

	# Refresh the editor and select the new node
	get_editor_interface().get_selection().clear()
	get_editor_interface().get_selection().add_node(converted_node)
	get_editor_interface().mark_scene_as_unsaved()  # Mark scene as modified


	# Move camera to the GridMap for visibility
	get_editor_interface().get_editor_viewport_3d(0).set_camera_position(converted_node.global_transform.origin)

func set_owners_recursive(node: Node, owner: Node):
	node.owner = owner
	for child in node.get_children():
		set_owners_recursive(child, owner)

func show_error(message: String):
	push_warning(message)
	var dialog = AcceptDialog.new()
	dialog.dialog_text = message
	dialog.title = "Converter Error"
	add_child(dialog)
	dialog.popup_centered()
	dialog.connect("popup_hide", dialog.queue_free)
