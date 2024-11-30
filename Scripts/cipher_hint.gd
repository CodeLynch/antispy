extends CanvasLayer
var is_used = false

signal ask_hint()

func _ready() -> void:
	is_used = false
	$HintUnused.visible = true
	$HintActive.visible = false
	$HintUnused/HoverLabel.visible = false

func open_hint(hint:String) -> void:
	is_used = true
	$HintUnused.visible = false
	$HintActive.visible = true
	$HintActive/HintText.text = hint

func _on_area_2d_mouse_entered() -> void:
	if !is_used:
		$HintUnused/HoverLabel.visible = true
		$HintUnused/Sprite2D.material.set_shader_parameter("is_active", true)

func _on_area_2d_mouse_exited() -> void:
	if !is_used:
		$HintUnused/HoverLabel.visible = false
		$HintUnused/Sprite2D.material.set_shader_parameter("is_active", false)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and !is_used:
		ask_hint.emit()
