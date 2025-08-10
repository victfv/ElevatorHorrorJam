extends CharacterBody3D

@onready var player: Player = get_node("/root/Level/Player")
@onready var timer: Timer = $Timer
@export var levelRoot: Node

@export var furniture : Array[DynamicObject] = []
var targetFurniture : DynamicObject = null
var heldFurniture : DynamicObject = null

enum MovingState {
	IDLE,
	GATHERING,
	CHOOSING,
	CHASING
}

@export var max_speed := 8.0           # Speed when far
@export var min_speed := 2.0           # Speed when very close
@export var stop_distance := 0.3       # How close before stopping
@export var slow_down_distance := 10.0
@export var distanceInFront := 2.0
@export var pickup_distance := 0.2 

var current_state = MovingState.GATHERING

func _ready():
	timer.start(3.0)

func _physics_process(delta: float) -> void:
	if current_state == MovingState.CHASING:
		chase_front_of_player()
		return
	if current_state == MovingState.GATHERING:
		picking_up_furniture()
		return
	if current_state == MovingState.CHOOSING:
		targetFurniture = get_farthest_furniture(furniture, global_transform.origin)
		current_state = MovingState.GATHERING
		return

func _on_timer_timeout():
	current_state = MovingState.GATHERING

func chase_front_of_player ():
	if player == null:
		return
	var direction = (player.global_position - global_position) 
	+ player.linear_velocity.normalized() * distanceInFront 
	var distance = direction.length()
	if distance <= stop_distance:
		velocity = Vector3.ZERO
		drop_furniture()
		current_state = MovingState.GATHERING
		move_and_slide()
		return
	direction = direction.normalized()
	# Calculate speed: slows down as distance decreases
	var t = clamp(distance / slow_down_distance, 0.0, 1.0)
	var speed = lerp(min_speed, max_speed, t)
	velocity = direction * speed
	move_and_slide()

func picking_up_furniture ():
	if targetFurniture == null:
		return
	var direction = (targetFurniture.global_position - global_position)
	var distance = direction.length()
	if distance <= pickup_distance:
		velocity = Vector3.ZERO
		take_furniture(targetFurniture)
		current_state = MovingState.CHASING
		move_and_slide()
		return
	return

func take_furniture(obj: Node3D):
	# Disable collisions
	for collider in obj.get_children():
		if collider is CollisionShape3D:
			collider.disabled = true
		elif collider is CollisionObject3D:
			collider.collision_layer = 0
			collider.collision_mask = 0

	# Reparent to this node
	obj.get_parent().remove_child(obj)
	add_child(obj)
	obj.global_transform = global_transform  # Optional: set position to parent’s

func drop_furniture():
	if heldFurniture == null:
		return

	# Enable collisions
	for collider in heldFurniture.find_children("*", "CollisionShape3D", true):
		collider.disabled = false
	for collider in heldFurniture.find_children("*", "CollisionObject3D", true):
		collider.collision_layer = 5
		collider.collision_mask = 1 | 2
	# Reparent to new parent (usually scene root)
	remove_child(heldFurniture)
	levelRoot.add_child(heldFurniture)
	heldFurniture = null

func get_farthest_furniture(furnitures: Array, origin: Vector3) -> DynamicObject:
	var farthest_furniture: DynamicObject = null
	var max_distance := -1.0
	
	for furniture in furnitures:
		if furniture and furniture is DynamicObject:
			var dist = origin.distance_to(furniture.global_transform.origin)
			if dist > max_distance:
				max_distance = dist
				farthest_furniture = furniture
				
	return farthest_furniture
