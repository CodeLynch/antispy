extends CanvasLayer

@export_file("*.json") var d_src 
@export var is_active = false

var SUCCESS_PROB = .7

var role_num = -1
var dialogue = []
var rng = RandomNumberGenerator.new()
var is_interrogation: bool = false
var is_kill: bool = false
var npc_id: int = -1
var io_is_spy: bool = false
'''
0 - Field Agent
1 - Analyst
2 - R&D Engineer
3 - Janitor
'''
signal kill_npc(id: int)

func _ready() -> void:
	$interrogate.visible = false
	$kill.visible = false
	$exit.visible = false
	$npc_dialogue.visible = false
	$rsa_dialogue.visible = false
	
func start(id:int, name:String, role: int, role_tex: String, is_spy:bool) -> void:
	if is_active:
		return
	is_active = true
	dialogue = load_dialogue()
	var s2dtex = load(role_tex)
	role_num = role
	npc_id = id
	io_is_spy = is_spy
	$npc_dialogue/Sprite2D.texture = s2dtex
	$npc_dialogue/npc_name.text = name
	$npc_dialogue/npc_role.text = "(" + dialogue[role+1][0]["role"] + ")"
	$npc_dialogue/dialogue_text.text = dialogue[role+1][0]["say"]
	show_overlay()

func load_dialogue():
	var file = FileAccess.open("res://Assets/Dialogue/DialogueMaster.json", FileAccess.READ)
	return JSON.parse_string(file.get_as_text())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if is_interrogation:
			$rsa_dialogue.visible = false
			$npc_dialogue/dialogue_text.text = dialogue[role_num + 1][rng.randi_range(1,4)]["say"]
			$kill.disabled = false
			$exit.disabled = false
			if io_is_spy and rng.randf_range(0,1) >= SUCCESS_PROB:
				$npc_dialogue/heart_rate.text = "[color=#e01f3f]HIGH[/color]"
			else:
				$npc_dialogue/heart_rate.text = "[color=#271d2c]NORMAL[/color]"
			show_overlay()
			is_interrogation = false
		elif is_kill:
			kill_npc.emit(npc_id)
			hide_overlay()
			is_kill = false	
			is_active = false		
		else:
			hide_overlay()
			is_active = false

func _on_interrogate_pressed() -> void:
	$interrogate.disabled = true
	$kill.disabled = true
	$exit.disabled = true
	$rsa_dialogue/dialogue_text.text = dialogue[0][0]["say"]
	$npc_dialogue.visible = false
	$rsa_dialogue.visible = true
	is_interrogation = true;

func _on_kill_pressed() -> void:
	$interrogate.disabled = true
	$kill.disabled = true
	$exit.disabled = true
	$rsa_dialogue/dialogue_text.text = dialogue[0][1]["say"]
	$npc_dialogue.visible = false
	$rsa_dialogue.visible = true
	is_kill = true;

	

func _on_exit_pressed() -> void:
	hide_overlay()
	is_active = false

func show_overlay() -> void:
	$npc_dialogue.visible = true
	$npc_dialogue/AnimatedSprite2D.play()
	$interrogate.visible = true
	$kill.visible = true
	$exit.visible = true
	
func hide_overlay() -> void:
	$npc_dialogue.visible = false
	$rsa_dialogue.visible = false
	$interrogate.disabled = false
	$kill.disabled = false
	$exit.disabled = false
	$interrogate.visible = false
	$kill.visible = false
	$exit.visible = false
