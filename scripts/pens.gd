extends Control
@onready var  pen_1 = $pen_1
@onready var  pen_2 = $pen_2
@onready var  pen_3 = $pen_3
@onready var left_btn = $left_btn
@onready var right_btn = $right_btn
@onready var back_btn = $back_btn

var pens = [pen_1,pen_2,pen_3]
func _ready() -> void:
	pens = [pen_1,pen_2,pen_3]
	pen_1.visible = true
	pen_2.visible = false
	pen_3.visible = false
	
	left_btn.pressed.connect(left_slide)
	
	right_btn.pressed.connect(right_slide)
	back_btn.pressed.connect(back)
	
	



func left_slide():
	var i =0
	for x in pens.size():
		if pens[x].visible == true:
			i = x
			
	if pens[i].visible == true and i > 0:
		pens[i].visible = false
		pens[i-1].visible = true
		
	else:
		pens[i].visible = false
		pens[i+2].visible = true
		
func right_slide(): #WILL IMPROVE THIS LOGIC by putting right slide iside left slide if else case and making right slide very short
	var i =0
	for x in pens.size():
		if pens[x].visible == true:
			i = x
	if pens[i].visible == true and i < 2:
		pens[i].visible = false
		pens[i+1].visible = true
		
	else:
		pens[i].visible = false
		pens[i-2].visible = true
		
		
				
func back():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
