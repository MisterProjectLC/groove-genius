extends Control

@export var right_answer : Array[Array]

@onready var blocks = $Blocks
@onready var over_blocks = $OverBlocks
@onready var instruments = $Instruments
@onready var puzzle_playback = $PuzzlePlayback

var current_slot = null


func _ready():
	for block in get_tree().get_nodes_in_group('block'):
		block.connect('dropped', Callable(self, 'on_block_dropped'))
	
	for slot in get_tree().get_nodes_in_group('slot'):
		slot.connect('mouse_on_changed', 
			Callable(self, 'on_slot_mouse_on_changed'))
	
	puzzle_playback.instruments = instruments.get_children()


func on_slot_mouse_on_changed(slot, m_on):
	if !m_on:
		current_slot = null
		return
	
	current_slot = slot


func on_block_dropped(block):
	if current_slot == null:
		call_deferred('deassign_block', block)
		return
	
	current_slot.set_block(block)
	block.global_position = current_slot.global_position
	call_deferred('assign_block', block)


func deassign_block(block):
	if block.assigned:
		block.assigned = false
		over_blocks.remove_child(block)
		blocks.add_child(block)


func assign_block(block):
	block.assigned = true
	blocks.remove_child(block)
	over_blocks.add_child(block)
	puzzle_playback.visible = (blocks.get_child_count() <= 0)
