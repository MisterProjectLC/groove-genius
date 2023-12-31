extends Control
class_name Menu

var starting = false
var quitting = false
@onready var start = $Buttons/Start

func _ready():
	Transitions.connect("transition_finished", Callable(self, "on_transition_finished"))
	if not start == null:
		start.grab_focus()


func _on_start_button_up():
	starting = true
	Transitions.play("BlackOut")

func on_transition_finished(_anim_name):
	if starting:
		GlobalNode.advance_stage()
	elif quitting:
		get_tree().quit()


func _on_options_button_up():
	$AnimationPlayer.play("ShowOptions")


func _on_quit_button_up():
	quitting = true
	Transitions.play("BlackOut")


func _on_options_menu_back_pressed():
	$AnimationPlayer.play_backwards("ShowOptions")
