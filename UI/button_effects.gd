extends Node

@onready var background: NinePatchRect = $"../Background"
var tween: Tween

func _ready() -> void:
	
	# change color of button with different states via modulate
	get_parent().mouse_entered.connect(_mouse_enter)
	get_parent().mouse_exited.connect(_mouse_exit)
	get_parent().button_down.connect(_button_down)
	get_parent().button_up.connect(_button_up)
	_mouse_exit() # reset
	
	# when clicking, do small scale bounce effect
	get_parent().pressed.connect(_mouse_press)
	
	# change cursor for button 
	get_parent().mouse_default_cursor_shape = Control.CursorShape.CURSOR_POINTING_HAND

func _process(delta: float) -> void:
	if get_parent().disabled:
		get_parent().modulate.a = 0.3
	else:
		get_parent().modulate.a = 1.0
		

func _mouse_press() -> void:
	_bounce_scale()
	
func _mouse_enter() -> void:
	background.self_modulate = Color.GRAY
	
func _mouse_exit() -> void:
	background.self_modulate = Color.WHITE

func _button_down() -> void:
	background.self_modulate = "#ffedd9"

func _button_up() -> void:
	background.self_modulate = Color.WHITE
	
func _bounce_scale() -> void:
	tween = create_tween()
	tween.tween_property(get_parent(), "scale", Vector2(1.05, 1.05), 0.1)
	tween.tween_property(get_parent(), "scale", Vector2(0.95, 0.95), 0.1)

func _reset_scale() -> void:
	if tween:
		tween.kill()
	background.scale = Vector2(1, 1)
