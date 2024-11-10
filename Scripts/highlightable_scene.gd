extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var npc_char: NPCChar = $"../NPCChar"

func _mouse_enter() -> void:
	if(npc_char.near_player):
		animated_sprite_2d.material.set_shader_parameter("is_active", true)
	
func _mouse_exit() -> void:
	if(npc_char.near_player):
		animated_sprite_2d.material.set_shader_parameter("is_active", false)

func _process(delta: float) -> void:
	if(!npc_char.near_player):
		animated_sprite_2d.material.set_shader_parameter("is_active", false)	
