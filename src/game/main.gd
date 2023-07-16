extends Control

@export var right_answer : Array[Array]
@export var initial_song_time = 0.0
@export var song_block_count = 4

@onready var blocks = $UnassignedBlocks
@onready var assigned_blocks = $AssignedBlocks
@onready var instruments = $Instruments

@onready var song_playback = $Playback
@onready var puzzle_playback = $PuzzlePlayback

var current_block = null
var block_count = 0
var block_assigned_count = 0


func _ready():
	for block in blocks.get_children():
		block.connect('pressed', Callable(self, 'on_block_pressed'))
		block_count += 1
	
	for slot in get_tree().get_nodes_in_group('slot'):
		slot.connect('pressed', Callable(self, 'on_slot_pressed'))
	
	song_playback.initial_song_time = initial_song_time
	puzzle_playback.initial_song_time = initial_song_time
	song_playback.song_block_count = song_block_count
	puzzle_playback.song_block_count = song_block_count
	puzzle_playback.instruments = instruments.get_children()


func _process(_delta):
	if current_block:
		current_block.global_position = get_viewport().get_mouse_position()


func on_slot_pressed(slot):
	if current_block:
		on_block_assigned(current_block, slot)
	else:
		var this_block = slot.get_block()
		if this_block:
			on_block_deassigned(this_block, slot)


func on_block_pressed(block):
	if current_block == block:
		on_block_dropped(block)
	elif current_block == null:
		on_block_held(block)
		await get_tree().process_frame
		blocks.remove_child(block)
		assigned_blocks.add_child(block)


func on_block_assigned(block, slot):
	current_block = null
	block_assigned_count += 1
	puzzle_playback.visible = (block_assigned_count >= block_count)
	
	slot.set_block(block)
	block.global_position = slot.global_position


func on_block_deassigned(block, slot):
	on_block_held(block)
	block_assigned_count -= 1
	puzzle_playback.visible = false
	
	slot.set_block(null)


func on_block_held(block):
	current_block = block


func on_block_dropped(block):
	current_block = null
	await get_tree().process_frame
	assigned_blocks.remove_child(block)
	blocks.add_child(block)
