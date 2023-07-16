extends Control

@export var song_piano : AudioStream
@export var song_violin : AudioStream
var mouse_on = 0
var assigned = false

signal dropped(block)

func _process(delta):
	if mouse_on > 0:
		mouse_on += delta
		if mouse_on >= 1.25 and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			global_position = get_viewport().get_mouse_position()


func _on_square_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			mouse_on = 1
		else:
			emit_signal("dropped", self)
			mouse_on = 0
