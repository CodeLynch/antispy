extends CharacterBody2D
@export var movement_speed: float = 50.0
@export var movement_len: float = 50.0
@export var pause_chance: float = 50
@export var pause_time: float = 1.0
@onready var detect_radius: Area2D = $DetectRadius
@onready var clickable_area: Area2D = $ClickableArea
@onready var npc_char: NPCChar = $NPCChar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


signal npc_clicked(id:int, name:String, role_int: int, role_tex: String, is_spy:bool)
signal npc_died(is_spy:bool)

var paused_time: float = 0
var is_paused: bool = false;
var movement_target_position: Vector2i = Vector2i(0,100)
var rng = RandomNumberGenerator.new()
var cancel_move: bool = false
var is_player_near: bool = false
var last_dir = 0
var escape: bool = false
var orig_movement_speed
var orig_movement_len

@onready var player: CharacterBody2D = get_parent().get_parent().get_node("Player")

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func set_params(id: int, name: String, role_no:int, is_anxious: bool, is_sus: bool, is_spy: bool):
	$NPCChar.npc_id = id
	$NPCChar.NPC_name = name
	$NPCChar.role_no = role_no
	$NPCChar.is_anxious = is_anxious
	$NPCChar.is_sus = is_sus
	$NPCChar.is_spy = is_spy 
	

#func _init() -> void:
#	movement_target_position = global_position + get_random_dir() * movement_len
	
	
func _ready():
	clickable_area.npc_clicked.connect(on_npc_click)
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	actor_setup.call_deferred()
	orig_movement_len = movement_len
	orig_movement_speed = movement_speed
	


func _process(delta):
	if is_paused:
		paused_time += delta
		if(paused_time >= pause_time):
			is_paused = false
			paused_time = 0

func _physics_process(_delta):
	if $NPCChar.near_player:
		change_anim_from_vec(Vector2i(0,0))
		return
		
	#if $NPCChar.is_anxious :
		#if $NPCChar.near_player and !escape:
			#cancel_move = true
			#escape = true
		#elif !$NPCChar.near_player:
			#cancel_move = false
			#escape = false
			#
	if navigation_agent.is_navigation_finished() or cancel_move:
		#if escape:
			#movement_speed *= 1.5
			#movement_target_position = (global_position + $NPCChar.esc_vector * movement_len)
			#set_movement_target(movement_target_position)
			#cancel_move = false
#else:
		movement_speed = orig_movement_speed
		handle_stop()
		if (!is_paused):
			var mov_vec = get_random_dir()
			movement_target_position = global_position + mov_vec * movement_len
			set_movement_target(movement_target_position)
			cancel_move = false
					
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	change_anim_from_vec(velocity)
	move_and_slide()
	var col_count = get_slide_collision_count()
	if col_count > 0:
		cancel_move = true

func die() -> void:
	npc_died.emit(npc_char.is_spy)
	queue_free()
	
func get_random_dir():
	var possible_vectors: Array = [Vector2i(0,1), Vector2i(0,-1), Vector2i(1,0), Vector2i(-1,0)]
	var rand_num = rng.randi_range(0, 3)
	return possible_vectors[rand_num]


func change_anim_from_vec(vec: Vector2i) -> void:
	if vec.x != 0:
		animated_sprite_2d.animation = "walk_s"
		last_dir = 2
		if vec.x > 0:
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = true
	elif vec.y != 0:
		if vec.y > 0:
			animated_sprite_2d.animation = "walk_f"
			last_dir = 0
		else:
			animated_sprite_2d.animation = "walk_b"
			last_dir = 1
	else:
		if last_dir == 0:
			animated_sprite_2d.animation = "idle"
		elif last_dir == 1:
			animated_sprite_2d.animation = "back"
		else:
			animated_sprite_2d.animation = "side"
	
func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func on_npc_click(id:int, name:String, role_int: int, role_tex: String, is_spy:bool):
	npc_clicked.emit(id, name, role_int, role_tex, is_spy)
	
func handle_stop():
	if(!is_paused):
		if(rng.randi_range(1, 100) <= pause_chance):
			is_paused = true
			change_anim_from_vec(Vector2i(0,0))
			


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
