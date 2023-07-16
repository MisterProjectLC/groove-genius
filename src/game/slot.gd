extends Control

var block = null

signal pressed(slot)

func set_block(this_block):
	block = this_block


func get_block():
	return block


func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal('pressed', self)
