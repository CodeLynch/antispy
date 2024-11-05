extends CharacterBody2D

const speed = 100


func get_input():
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	velocity = dir * speed
	
	
	
func _physics_process(delta):
	get_input()
	move_and_slide()
	
