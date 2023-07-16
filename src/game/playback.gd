extends HSlider
class_name Playback

@export var play_texture : Texture
@export var pause_texture : Texture

@onready var button = $Button
var paused = true


func _process(delta):
	if !paused:
		value += delta
		if value >= max_value:
			toggle_pause()


func play(_v):
	pass

func stop():
	pass


func toggle_pause():
	paused = !paused
	button.icon = play_texture if paused else pause_texture
	
	if paused:
		stop()
	else:
		play(value)


func _on_drag_ended(_value_changed):
	if !paused:
		play(value)

func _on_button_pressed():
	toggle_pause()
