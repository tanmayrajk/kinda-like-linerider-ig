extends Control

@onready var play_button = $play_button
@onready var garage_button = $garage_button
@onready var pens_button = $pens_button
@onready var level_button = $level_button
@onready var setting_button = $setting_button

func _ready() -> void:
	play_button.pressed.connect(play)
	garage_button.pressed.connect(garage_open)
	pens_button.pressed.connect(pens_select)
	level_button.pressed.connect(level_select)
	setting_button.pressed.connect(setting_open)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func play():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
func garage_open():
	get_tree().change_scene_to_file("")
	
func pens_select():
	get_tree().change_scene_to_file("res://scenes/pen.tscn")
	
func level_select():
	get_tree().change_scene_to_file("")
	
func setting_open():
	get_tree().change_scene_to_file("")
