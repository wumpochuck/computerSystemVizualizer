extends Node2D

var arr1 = []
var arr2 = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_load_pressed():
	var textForArr1 = $Input1/MarginContainer/TextEdit
	var textForArr2 = $Input2/MarginContainer2/TextEdit
	arr1 = textForArr1.text.split('\n')
	arr2 = textForArr2.text.split('\n')
	var res = proverka()

	print(res)
	'''
	Написать проверку введённых массивов на интовые числа, в каждом массиве
	должно быть по 8 floatовских чисел
	
	Если проверка true, вызывается функция создания
	
	'''

func proverka():
	var count1 = 0
	var count2 = 0
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

func createGraph():
	pass
	'''
	Создается главный слой, который потом удаляется кнопкой стереть
	На нем ебашится график (тут над алгоритмом подумать)
	
	Заранее объявить 2 переменные с выводами, сколько случилось отказов
	и сколько заявок обработано.
	Эти переменные в виде строк будут потом отправляться в спрайт "Info"
	
	'''