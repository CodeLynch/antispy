extends Node2D
class_name NPCChar


@export var npc_id: int
@export var is_spy: bool 
@export var NPC_name: String  
@export var is_sus: bool 
@export var is_anxious: bool 
@export var heart_rate: int 
@export var portrait_texture: String 
@export var role_no: int
@export var is_talking: bool = false
@export var is_dead:bool
@onready var player: CharacterBody2D = get_parent().get_parent().get_parent().get_node("Player")


var near_player: bool = false
	
func _on_detect_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		near_player = true
		
func _on_detect_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		near_player = false
