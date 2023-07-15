extends Control

@onready var blocks = $Blocks
@onready var slots = $Slots
@onready var over_blocks = $OverBlocks

var current_slot = null


func _ready():
	for block in get_tree().get_nodes_in_group('block'):
		block.connect('dropped', Callable(self, 'on_block_dropped'))
	
	for slot in get_tree().get_nodes_in_group('slot'):
		slot.connect('mouse_on_changed', 
			Callable(self, 'on_slot_mouse_on_changed'))


func on_slot_mouse_on_changed(slot, m_on):
	if !m_on:
		current_slot = null
		return
	
	current_slot = slot


func on_block_dropped(block):
	if current_slot == null:
		over_blocks.call_deferred('remove_child', block)
		blocks.call_deferred('add_child', block)
		return
	
	block.global_position = current_slot.global_position
	blocks.call_deferred('remove_child', block)
	over_blocks.call_deferred('add_child', block)

