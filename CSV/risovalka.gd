extends Node2D

var zaebok = []
var otkaz = []
var vremya_prostoya
const multiplier = 38.4 # Пикселей в 1й секунде
const Yproc = 96+2 - 42.5# Пикселей
const Ynak = 200+2 - 42.5
const Yotk = 304+2 - 42.5
const Ygood = 408+2 - 42.5
# Высота блоков = 48 пикселей
# 64 пикселя - 1 секунда
# 0.067 3.633
var proc_time = 0
var switcher = 1
func draw_block(start,duration,kyda,index):
	var block = Sprite2D.new()
	block.texture = load('res://assets/1243'+str(switcher)+'.png')
	switcher = -switcher
	block.centered = false
	var blocktext = Label.new()
	blocktext.text = str(index)
	if(kyda == 'proc'):
		block.position.x = start * multiplier
		block.position.y = Yproc

		blocktext.position = Vector2(start*multiplier + 2,Yproc)
		proc_time += start+duration
		draw_lines(start+duration,'norm',index)
		draw_lines(start,'proc',index)
		
	if(kyda == 'nako'): 
		block.position.x = start * multiplier
		block.position.y = Ynak
		proc_time += duration
		#draw_block(proc_time,duration,'proc',index)
		draw_lines(start,'nako',index)
		draw_lines(proc_time,'norm',index)
		blocktext.position = Vector2(start*multiplier + 2,Ynak)
		
		
	block.scale.x = duration * multiplier
	blocktext.add_theme_color_override('font_color',Color(255,255,255,1))
	add_child(block)
	add_child(blocktext)
	
	

	pass

func draw_lines(start,kyda,index):
	var pynktir = Sprite2D.new()
	pynktir.texture = load('res://assets/Sprite-0001.png')
	pynktir.centered = false
	# -------------
	var linetext = Label.new()
	linetext.text = str(start)
	linetext.rotation = -1.57
	linetext.add_theme_font_size_override('font_size',8)
	linetext.add_theme_color_override('font_color',Color(0,0,0,1))
	linetext.position = Vector2(start * multiplier-10, -2)
	#add_child(linetext)
	# -------------
	var indextext = Label.new()
	indextext.text = str(index)
	indextext.add_theme_font_size_override('font_size',10)
	indextext.add_theme_color_override('font_color',Color(0,0,0,1))
	indextext.position = Vector2(start * multiplier, -2 + 3*104)
	# -------------
	if kyda == 'norm':
		for i in range(1,4):
			pynktir.position.y = -2 + i*104	
			pynktir.position.x = start * multiplier
			add_child(pynktir)
			pynktir = Sprite2D.new()
			pynktir.texture = load('res://assets/Sprite-0001.png')
			pynktir.centered = false
			indextext.position = Vector2(start * multiplier, -2 + 4*104)
			add_child(indextext)
	else:
		add_child(linetext)
		if kyda == 'proc':
			pynktir.position.y = -2
			pynktir.position.x = start * multiplier
			add_child(pynktir)
		elif kyda == 'otk':
			for i in range(0,3):
				pynktir.position.y = -2 + i*104	
				pynktir.position.x = start * multiplier
				add_child(pynktir)
				pynktir = Sprite2D.new()
				pynktir.texture = load('res://assets/Sprite-0001.png')
				pynktir.centered = false
			indextext.text = str(index+1)
			add_child(indextext)
		elif kyda == 'nako':
			for i in range(0,2):
				pynktir.position.y = -2 + i*104	
				pynktir.position.x = start * multiplier
				add_child(pynktir)
				pynktir = Sprite2D.new()
				pynktir.texture = load('res://assets/Sprite-0001.png')
				pynktir.centered = false
		else:
			pass
			
				

func obrabotka(starts,duration):
	zaebok = []
	otkaz = []
	proc_time = 0
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
			draw_block(starts[i],duration[i],'proc',i+1)
			zaebok.append(i+1)
		elif not nak_busy:
			zayavka_v_nak = [time_proc,duration[i]]
			# Функция постройки в накопителе
			draw_block(starts[i],duration[i],'nako',i+1)
			zaebok.append(i+1)
			nak_busy = true
		elif nak_busy and starts[i] not in zaebok:
			# Функция постройки штриха
			draw_lines(starts[i],'otk',i)
			otkaz.append(i+1)
	vremya_prostoya = starts[0] + (19-(zayavka_v_nak[0] + zayavka_v_nak[1]))
	podgryzInfo()

'''
func obrabotka(starts,duration):
	zaebok = []
	otkaz = []
	proc_time = 0
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
			draw_block(starts[i],duration[i],'proc',i+1)
			zaebok.append(i+1)
			nak_busy = true
		elif not nak_busy:
			zayavka_v_nak = [time_proc,duration[i]]
			# Функция постройки в накопителе
			draw_block(starts[i],duration[i],'nako',i+1)
			zaebok.append(i+1)
			nak_busy = true
		elif nak_busy and starts[i] not in zaebok:
			# Функция постройки штриха
			draw_lines(starts[i],'otk',i)
			otkaz.append(i+1)
	vremya_prostoya = 0#= starts[0] + (19-(zayavka_v_nak[0] + zayavka_v_nak[1]))
	podgryzInfo()
'''
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(20):
		var sekynda = Label.new()
		sekynda.text = str(i)
		sekynda.position.x = (i)*multiplier
		sekynda.position.y = -42
		sekynda.add_theme_color_override('font_color',Color(255,255,255,1))
		add_child(sekynda)
	var proctext = Label.new()
	proctext.text = "Проц."
	proctext.position = Vector2(-47,Yproc + 42.5 - 20)
	proctext.add_theme_color_override('font_color',Color(0,0,0,1))
	add_child(proctext)
	var nako = Label.new()
	nako.text = "Нак."
	nako.position = Vector2(-47,Ynak + 42.5 - 20)
	nako.add_theme_color_override('font_color',Color(0,0,0,1))
	add_child(nako)
	var otk = Label.new()
	otk.text = "Отк."
	otk.position = Vector2(-47,Yotk + 42.5 - 20)
	otk.add_theme_color_override('font_color',Color(0,0,0,1))
	add_child(otk)
	var norm = Label.new()
	norm.text = "Обр."
	norm.position = Vector2(-47,Ygood + 42.5 - 20)
	norm.add_theme_color_override('font_color',Color(0,0,0,1))
	add_child(norm)
		


func podgryzInfo():
	var info = get_tree().get_first_node_in_group('Info')
	var text = info.get_child(0)
	text.text = 'Заявок обработано: ' + str(zaebok.size()) \
	+ '\nОбработаны: ' + str(zaebok) + '\nНеобработаны: ' \
	+ str(otkaz) + '\nПроцессор бездействовал:\n' + str(vremya_prostoya) \
	+ 'с из 19с (' + str(snapped(vremya_prostoya/19 *100,0.1)) +'%).'
	pass
	

