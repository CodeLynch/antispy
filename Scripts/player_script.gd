extends CharacterBody2D

const speed = 150
var direction = Vector3()
var role_arr:Array = ["field_agent", "analyst", "rd_eng", "janitor"]
var last_dir = 0
@onready var sprite = $AnimatedSprite2D
@onready var spy_detect: Area2D = $SpyDetect
@export var can_move = true


signal spy_near(is_near:bool)
signal attempt_made(new_count)
	
func _physics_process(_delta):
	get_input()
	if can_move:
		move_and_slide()

func get_input():
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	if dir.x != 0:
		if dir.x > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		sprite.animation = "walk_s"
		last_dir = 2
	elif dir.y > 0:
		sprite.animation = "walk_f"
		last_dir = 0
	elif dir.y < 0:
		sprite.animation = "walk_b"
		last_dir = 1
	else:
		if last_dir == 1:
			sprite.animation = "back"
		elif last_dir == 2:
			sprite.animation = "side"
		else:
			sprite.animation = "idle"	
	velocity = dir.normalized() * speed
	direction = velocity

func _on_spy_detect_body_entered(body: Node2D) -> void:
	var bodies = spy_detect.get_overlapping_bodies()
	for bod in bodies:
		if name_matches_role(bod.name) and bod.npc_char.is_sus:
			spy_near.emit(true) 
			return
	spy_near.emit(false)

func _on_spy_detect_body_exited(body: Node2D) -> void:
	var bodies = spy_detect.get_overlapping_bodies()
	for bod in bodies:
		if name_matches_role(bod.name) and bod.npc_char.is_sus:
			spy_near.emit(true) 
			return
	spy_near.emit(false)

func name_matches_role(name:String) -> bool:
	for role in role_arr:
		if name.contains(role):
			return true
	return false
