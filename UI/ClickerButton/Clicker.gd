extends TextureButton

var baseCost: int = 10
var currentThreshold: int = 0
var currentThresholdIndex: int = 0

func _ready():
	# load settings from save file maybe?
	currentThreshold = Global.multiThreshold[currentThresholdIndex]
	
	pressed.connect(_on_click)

func _process(_delta):
	if Global.persistentOwnedClickers == currentThreshold and \
		Global.multiThreshold[currentThresholdIndex] == currentThreshold:
		currentThresholdIndex += 1
		currentThreshold = Global.multiThreshold[currentThresholdIndex]
		
	$Label.text = "Click For +" + str(CalcPoints()) + " Point(s)\n" +\
		"Level: " + str(Global.persistentOwnedClickers)

func _on_click():
	Global.persistentCurrentPoints += CalcPoints()

func CalcPoints():
	return Global.persistentOwnedClickers * pow(2, currentThresholdIndex)
