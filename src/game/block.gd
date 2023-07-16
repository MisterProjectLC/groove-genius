extends Control

@export var song_piano : AudioStream
@export var song_violin : AudioStream

signal pressed(block)

func _on_square_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("pressed", self)
