extends Control

@export var song_piano : AudioStream
@export var song_violin : AudioStream

@export var image : Texture

@export var should_be_piano = true
@export var right_time = [0]

signal pressed(block)


func _ready():
	$Pattern.texture = image


func _on_square_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("pressed", self)
