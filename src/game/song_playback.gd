extends Playback

@export var music : AudioStream


func _ready():
	max_value = music.get_length()


func play(v):
	$BGM.play(v + GlobalNode.BLOCK_DURATION*initial_song_time)

func stop():
	$BGM.stop()
