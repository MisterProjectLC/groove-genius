extends HSlider

@export var play_texture : Texture
@export var pause_texture : Texture
@export var music : AudioStream

@onready var button = $Button
var paused = true


func _ready():
	max_value = music.get_length()


func _process(delta):
	if !paused:
		value += delta


func _on_button_pressed():
	paused = !paused
	button.icon = play_texture if paused else pause_texture
	
	if paused:
		$BGM.stop()
	else:
		$BGM.play(value)


func _on_drag_ended(_value_changed):
	if !paused:
		$BGM.play(value)
