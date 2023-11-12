extends Node2D

var zaebok = []
var otkaz = []
var vremya_prostoya
const multiplier = 38.4 # Пикселей в 1й секунде
const Yproc = 96-2 - 42.5# Пикселей
const Ynak = 200-2 - 42.5
const Yotk = 304-2 - 42.5
const Ygood = 408-2 - 42.5
# Высота блоков = 48 пикселей
# 64 пикселя - 1 секунда
# 0.067 3.633
func draw_block(start,duration,kyda):
	var block = Sprite2D.new()
	block.texture = load('res://assets/xlel.png')
	block.centered = false
	if(kyda == 'proc'):
		block.position.x = start * multiplier
		block.position.y = Yproc
	block.scale.x = duration * multiplier
	add_child(block)
	if(kyda == 'nako'):
		block.position.x = start * multiplier
		block.position.y = Ynak
	block.scale.x = duration * multiplier
	add_child(block)
	
	
	'''
	var builder = $Builder
	var block = Sprite2D.new()
	block.texture = load('res://assets/block semidark.png')
	block.position.x += 3.24 * 64
	block.offset.x += 50
	block.offset.y += 150
	builder.add_child(block)
	# 3.24
	'''
	pass

func draw_lines(start,kyda):
	var pynktir = Sprite2D.new()
	pynktir.texture = load('res://assets/пунктир.png')
	pynktir.centered = false
	if (kyda == 'otkaz'):
		pynktir.position.x = start * multiplier
		pynktir.position.y = 0
	add_child(pynktir)
	

var a = [0.067, 0.444, 1.044, 1.438, 1.509, 3.033, 4.097, 5.244]
var b = [3.633, 2.044, 4.219, 1.652, 0.791, 1.375, 6.36, 5.569]

func obrabotka(starts,duration):
	zaebok = []
	otkaz = []
	var time_proc = 0.0
	var zayavka_v_nak = []
	var nak_busy = false
	for i in range(8):
		if zayavka_v_nak and starts[i] > time_proc:
			time_proc = zayavka_v_nak[0] + zayavka_v_nak[1]
			nak_busy = false


		if starts[i] >= time_proc:
			time_proc = starts[i] + duration[i]
			# Функция постройки в проце
			draw_block(starts[i],duration[i],'proc')
			zaebok.append(i+1)
		elif not nak_busy:
			zayavka_v_nak = [time_proc,duration[i]]
			# Функция постройки в накопителе
			draw_block(starts[i],duration[i],'nako')
			zaebok.append(i+1)
			nak_busy = true
		else:
			# Функция постройки штриха
			draw_lines(starts[i],'otkaz')
			otkaz.append(i+1)
	vremya_prostoya = starts[0] + (20-(zayavka_v_nak[0] + zayavka_v_nak[1]))
	


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(20):
		var sekynda = Label.new()
		sekynda.text = str(i)
		sekynda.position.x = (i)*multiplier
		sekynda.position.y = -20
		sekynda.add_theme_color_override('font_color',Color(0,0,0,1))
		add_child(sekynda)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	

func _on_texture_button_pressed():
	#draw_block(0.067,3.633,'proc')
	obrabotka(a,b)
