extends CharacterBody3D
class_name Ghost

@onready var player: Player = get_node("/root/Level/Player")
@onready var timer: Timer = $Timer

enum State {
	IDLE,
	CHASING,
	DISSAPEARING
}

@export var max_speed := 8.0           # Speed when far
@export var min_speed := 2.0           # Speed when very close
@export var stop_distance := 1.0       # How close before stopping
@export var slow_down_distance := 10.0 # Distance at which to start slowing down

@export var respawn_distance: float = 20.0
@export var min_distance_from_player: float = 15.0
@export var max_spot_distance: float = 5.0

var current_state = State.IDLE

func _ready():
	timer.start(3.0)

func _on_timer_timeout():
	current_state = State.CHASING

func _process(delta):
	if is_spotted_by_player():
		dissapear()

func _physics_process(delta: float) -> void:
	if current_state == State.CHASING:
		chase_player()

func chase_player ():
	if player == null:
		return

	var direction = (player.global_position - global_position)
	var distance = direction.length()

	if distance <= stop_distance:
		velocity = Vector3.ZERO
		move_and_slide()
		return

	direction = direction.normalized()

	# Calculate speed: slows down as distance decreases
	var t = clamp(distance / slow_down_distance, 0.0, 1.0)
	var speed = lerp(min_speed, max_speed, t)

	velocity = direction * speed
	move_and_slide()

func is_spotted_by_player() -> bool:
	var to_enemy = global_transform.origin - player.global_transform.origin
	var distance = to_enemy.length()
	if distance > max_spot_distance:
		return false
	var forward = -player.global_transform.basis.z
	return to_enemy.normalized().dot(forward) > 0.9  # roughly in front of player

func dissapear ():
	hide()
	current_state = State.DISSAPEARING
	await get_tree().create_timer(0.5).timeout  # short delay before respawning
	relocate ()
	show()
	current_state = State.CHASING

func relocate():
	var new_position = global_transform.origin
	var max_attempts = 10
	var attempts = 0
	
	while attempts < max_attempts:
		var random_offset = Vector3(
			randf_range(-respawn_distance, respawn_distance),
			0,
			randf_range(-respawn_distance, respawn_distance)
		)
		new_position = player.global_transform.origin + random_offset

		if new_position.distance_to(player.global_transform.origin) > min_distance_from_player:
			break

		attempts += 1

	global_transform.origin = new_position
