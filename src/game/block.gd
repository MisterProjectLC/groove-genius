extends Control

@export var _label = ""
var mouse_on = 0

signal clicked()
signal dropped(block)


func get_label():
	return _label

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
			if mouse_on < 1.25:
				emit_signal("clicked")
			else:
				emit_signal("dropped", self)
			mouse_on = 0
