extends CharacterBody2D
@onready var npc_var = $NPCChar
@export var movement_speed: float = 50.0
@export var movement_len: float = 50.0
@export var pause_chance: float = 50
@export var pause_time: float = 1.0
@onready var detect_radius: Area2D = $DetectRadius

var paused_time: float = 0
var is_paused: bool = false;
var movement_target_position: Vector2i = Vector2i(0,0)
var rng = RandomNumberGenerator.new()
var cancel_move: bool = false
var is_player_near: bool = false

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	actor_setup.call_deferred()
	get_random_dir()

func get_random_dir():
	var possible_vectors: Array = [Vector2i(0,1), Vector2i(0,-1), Vector2i(1,0), Vector2i(-1,0)]
	var rand_num = rng.randi_range(0, 3)
	return possible_vectors[rand_num]
	
func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func handle_stop():
	if(!is_paused):
		if(rng.randi_range(1, 100) <= pause_chance):
			is_paused = true

func _process(delta):
	if is_paused:
		paused_time += delta
		if(paused_time >= pause_time):
			is_paused = false
			paused_time = 0

func _physics_process(_delta):
	if npc_var.near_player:
		return
	if navigation_agent.is_navigation_finished() or cancel_move:
		handle_stop()
		if (!is_paused):
			movement_target_position = global_position + get_random_dir() * movement_len
			set_movement_target(movement_target_position)
			cancel_move = false
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
	
	var col_count = get_slide_collision_count()
	if col_count > 0:
		cancel_move = true
