extends Control

var mouse_on = false
var block = null

signal mouse_on_changed(slot)


func set_block(this_block):
	block = this_block


func _on_square_mouse_entered():
	mouse_on = true
	emit_signal('mouse_on_changed', self, mouse_on)


func _on_square_mouse_exited():
	mouse_on = false
	emit_signal('mouse_on_changed', self, mouse_on)
