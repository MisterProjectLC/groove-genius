extends Playback

var instruments = []


func play(v):
	$BGM.play(v + GlobalNode.BLOCK_DURATION*initial_song_time)
	for instrument in instruments:
		instrument.play(v)

func stop():
	$BGM.stop()
	for instrument in instruments:
		instrument.stop()
