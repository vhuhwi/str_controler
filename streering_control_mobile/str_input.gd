extends Control
var vec_def_v =Vector2.ZERO
var str_rot =0
export var str_x_perc :int
export var str_y_perc :int
var curent_rect_size 
var viewport_size   =Vector2.ZERO setget rect_change
var sprite_size     = Vector2(128,128)
onready var str_wheel = get_node("StrWheel")
var str_vector =Vector2.ZERO
var last_dot = 0



func _ready():
	str_config()

func _physics_process(delta):
	$StrWheel/spite.rotation_degrees=-str_rot*80
	
	var mouse_position = get_viewport().get_mouse_position()
	if curent_rect_size != get_viewport_rect().size:
		self.viewport_size =get_viewport_rect().size
	
func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $StrWheel.is_pressed():
			_calc_vector()
		
	
		
func rect_change(value):
	viewport_size =value
#	print("rect_size_changed")
	curent_rect_size =viewport_size
	str_config()
	
func _percentage(perc,_len):
	return (perc/100.0)*_len
func str_config():
	var mouse_position = get_viewport().get_mouse_position()
	viewport_size =get_viewport_rect().size
	curent_rect_size =viewport_size
	print(viewport_size)
	str_wheel.position =Vector2(_percentage(str_x_perc,viewport_size.x),_percentage(str_y_perc,viewport_size.y))
	str_wheel.position += Vector2(64,-128)

func dot_opp(vectorX,vectorY):
	
	return vectorX.dot(vectorY)
	
func _main_logic():
	pass
	
func _calc_vector():
	
	var mouse_vector = get_viewport().get_mouse_position()
	mouse_vector  -=str_wheel.position +Vector2(64,64)
#	print(dot_opp(Vector2.UP.normalized(),mouse_vector.normalized()))
	var dot_dif =last_dot-dot_opp(Vector2.UP.normalized(),mouse_vector.normalized())
	last_dot = dot_opp(Vector2.UP.normalized(),mouse_vector.normalized())
#	print(dot_dif)
	_speat_quadrant(mouse_vector)
	if _speat_quadrant(mouse_vector)==1 or _speat_quadrant(mouse_vector)==4:
		str_rot -=dot_dif
	else:
		str_rot +=dot_dif
	print(str_rot)
	str_rot =clamp(str_rot,-4,4)
#	print(sign(dot_opp(Vector2.UP.normalized(),mouse_vector.normalized())))
#	print(sign(dot_opp(Vector2.DOWN.normalized(),mouse_vector.normalized())))
#	print(sign(dot_opp(Vector2.RIGHT.normalized(),mouse_vector.normalized())))
#	print(sign(dot_opp(Vector2.LEFT.normalized(),m$StrWheel/CollisionShape2Douse_vector.normalized())))
#	pass 
func _speat_quadrant(mouse_vector):
	var a =sign(dot_opp(Vector2.UP.normalized(),mouse_vector.normalized()))
	var b =sign(dot_opp(Vector2.DOWN.normalized(),mouse_vector.normalized()))
	var c =sign(dot_opp(Vector2.RIGHT.normalized(),mouse_vector.normalized()))
	var d =sign(dot_opp(Vector2.LEFT.normalized(),mouse_vector.normalized()))
	if a==1 && b==-1 && c ==1 && d==-1:
		return 1
	elif a==1 && b==-1 && c ==-1 && d==1:
		return 2
	elif a==-1 && b==1 && c ==-1 && d==1:
		return 3
	else :
		return 4



func _on_StrWheel_pressed():
	print("print_something")
	var mouse_vector = get_viewport().get_mouse_position()
	mouse_vector  -=str_wheel.position +Vector2(64,64)
	last_dot = dot_opp(Vector2.UP.normalized(),mouse_vector.normalized())
