extends HSlider
class_name Playback

signal reached_end()

@export var play_texture : Texture
@export var pause_texture : Texture

@onready var button = $Button
var paused = true

var initial_song_time = 0.0
var song_block_count = 4 : set = set_song_block_duration

func _ready():
	max_value = GlobalNode.BLOCK_DURATION*song_block_count

func set_song_block_duration(s):
	song_block_count = s
	max_value = GlobalNode.BLOCK_DURATION*song_block_count


func _process(delta):
	if !paused:
		value += delta
		if value >= max_value:
			toggle_pause()
			value = 0
			emit_signal('reached_end')


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
		stop()
		play(value)

func _on_button_pressed():
	toggle_pause()
