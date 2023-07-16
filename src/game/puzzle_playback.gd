extends Playback

var instruments = []


func _ready():
	max_value = GlobalNode.BLOCK_DURATION*4


func play(v):
	for instrument in instruments:
		instrument.play(v)

func stop():
	for instrument in instruments:
		instrument.stop()
