extends Node

signal on_cutscene_changed(in_cutscene)

@export var stages : Array[PackedScene]
var current_stage = 0

var music_volume = 0.5
var sound_volume = 0.5
var souvenirs = [false, false, false, false, false, false, false]

const BLOCK_DURATION = 2.0


var _in_cutscene = false
func set_in_cutscene(value):
	_in_cutscene = value
	emit_signal("on_cutscene_changed", value)

func get_in_cutscene():
	return _in_cutscene


var camera_zoom = 0.25
func get_camera_zoom():
	return camera_zoom

func set_camera_zoom(z):
	camera_zoom = z


func advance_stage():
	get_tree().change_scene_to_packed(stages[current_stage])
	current_stage += 1
	if current_stage >= stages.size():
		current_stage = 0


@export var _debug = false
func in_debug():
	return _debug
