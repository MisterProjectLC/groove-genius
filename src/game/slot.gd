extends Control

@export var _label = ""
var mouse_on = false

signal mouse_on_changed(slot)


func get_label():
	return _label


func _on_square_mouse_entered():
	mouse_on = true
	emit_signal('mouse_on_changed', self, mouse_on)


func _on_square_mouse_exited():
	mouse_on = false
	emit_signal('mouse_on_changed', self, mouse_on)
