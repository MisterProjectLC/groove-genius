@tool
extends Control

@export var texture : Texture
@export var is_piano = true
@export var disabled = false

@onready var image = $Image
@onready var slots = $Slots
@onready var music = $BGM
@onready var music2 = $BGM2
@onready var timer = $Timer

var next_music_index = 0
var first_player_index = true

func _ready():
	image.texture = texture
	visible = !disabled


func set_slot_index(max_index):
	for i in range(max_index, slots.get_child_count()):
		slots.call_deferred('remove_child', slots.get_child(i))


func play(time : float):
	var index = floori(time / GlobalNode.BLOCK_DURATION)
	var timestamp = time - (index*GlobalNode.BLOCK_DURATION)
	next_music_index = index+1
	
	if index >= slots.get_child_count():
		return
	
	timer.start(GlobalNode.BLOCK_DURATION-timestamp)
	if slots.get_child(index).block == null:
		return
	
	var player = music if first_player_index else music2
	player.stream = (slots.get_child(index).block.song_piano if is_piano 
		else slots.get_child(index).block.song_violin)
	player.play(timestamp)
	first_player_index = !first_player_index


func stop():
	music.stop()
	music2.stop()
	timer.stop()


func check_correctness():
	if disabled:
		return true
	
	var i = 0
	for slot in slots.get_children():
		var block = slot.get_block()
		if block == null:
			return false
		var is_time_right = false
		for this_time in block.right_time:
			if this_time == i:
				is_time_right = true
				break
		if !is_time_right:
			return false
		if block.should_be_piano != is_piano:
			return false
		i += 1
	
	return true


func _on_timer_timeout():
	play(next_music_index*GlobalNode.BLOCK_DURATION)
