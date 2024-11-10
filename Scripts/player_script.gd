extends CharacterBody2D

const speed = 150
var direction = Vector3()
@onready var sprite = $AnimatedSprite2D

func get_input():
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	velocity = dir.normalized() * speed
	direction = velocity
	
	
func _physics_process(_delta):
	get_input()
	move_and_slide()
	
	
