extends Node2D

var arr1 = []
var arr2 = []
var times1 = []
var times2 = []

#var a = [0.067, 0.444, 1.044, 1.438, 1.509, 3.033, 4.097, 5.244]
#var b = [3.633, 2.044, 4.219, 1.652, 0.791, 1.375, 6.36, 5.569]
# Для графика вызвать обработку из рисовалки

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_load_pressed():

	pass
	var textForArr1 = $Input1/MarginContainer/TextEdit
	var textForArr2 = $Input2/MarginContainer2/TextEdit
	arr1 = textForArr1.text.split('\n')
	arr2 = textForArr2.text.split('\n')
	var res = proverka()
	
	if res:
		var risovalka = $risovalka
		while(risovalka.get_child(24)):
			risovalka.get_child(24).free()
		var a = []
		for ele1 in arr1:
			a.append(float(ele1))
		var b = []
		for ele2 in arr2:
			b.append(float(ele2))
			
		print(a)
		print(b)
		$risovalka.obrabotka(a,b)
	else:
		$ButtonLoad/Label.text = "Неверные\nданные"
		$ButtonLoad/Label.add_theme_font_size_override("font_size",14)
		await get_tree().create_timer(1.0).timeout
		$ButtonLoad/Label.text = "Построить"
		$ButtonLoad/Label.add_theme_font_size_override("font_size",18)

	print(res)
	

func _on_button_random_pressed():
	createArrFunction()
	var textForArr1 = $Input1/MarginContainer/TextEdit
	var textForArr2 = $Input2/MarginContainer2/TextEdit
	var str1 = ''
	var str2 =''
	for i in range(8):
		str1 += str(arr1[i])
		str2 += str(arr2[i])
		if i != 7:
			str1 += '\n'
			str2 += '\n'
	textForArr1.text = str1
	textForArr2.text = str2

func _on_button_clear_pressed():
	var textForArr1 = $Input1/MarginContainer/TextEdit
	var textForArr2 = $Input2/MarginContainer2/TextEdit
	textForArr1.text = ''
	textForArr2.text = ''
	var risovalka = $risovalka
	while(risovalka.get_child(24)):
		risovalka.get_child(24).free()
	$Info/infotext.text = 'Заявок обработано: \nОбработаны: \nНеобработаны: \nПроцессор бездействовал:\n'
	pass # Replace with function body.

func proverka():
	var count1 = 0
	var count2 = 0
	if arr1.size() != 8 or arr2.size() != 8:
		return false
	for ele in arr1:
		count1 += 1
		var ele1 = float(ele)
		if(str(ele1) != ele):
			return false
		#res = res * ele.isdigit()
	for ele in arr2:
		count2 += 1
		var ele1 = float(ele)
		if(str(ele1) != ele):
			return false
		#res = res * ele.isdigit()
	if count1 != count2:
		return false
	return true

func logariphm():
	return (-1 * log(randf())) / 0.52

func createArrFunction():
	arr1 = []
	arr2 = []
	for i in range(8):
		arr1.append(snapped(logariphm(),0.001))
		arr2.append(snapped(logariphm(),0.001))
	
	arr1.sort()
	print(arr1)
	print(arr2)
	


