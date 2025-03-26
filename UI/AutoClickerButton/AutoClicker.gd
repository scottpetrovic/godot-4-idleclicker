extends TextureButton

var index : int = 0
var baseCost : int = 0
var cps : int = 0
var currentThreshold: int = 0
var currentThresholdIndex: int = 0

func _ready():
	# Compose AutoClicker
	currentThresholdIndex = 0
	currentThreshold = Global.multiThreshold[currentThresholdIndex]
	index = Global.persistentOwnedAutos
	baseCost = Global.AutoClickData[index].BaseCost
	cps = Global.AutoClickData[index].CPS
	Global.persistentOwnedAutos += 1

	pressed.connect(_on_click)

func _process(delta):
	if Global.AutoClickData[index].Amount == currentThreshold and \
		Global.multiThreshold[currentThresholdIndex] == currentThreshold:
		currentThresholdIndex += 1
		currentThreshold = Global.multiThreshold[currentThresholdIndex]
		
	# we have the auto-clicker upgrade...so show information
	if (Global.persistentOwnedAutos > 0):
		$Label.text = str(CalcPoints()) + " Points/s\n" + \
			"Upgrade Cost: " + str(CalculateCost())
		$Level.text = "Level: " + str(Global.AutoClickData[index].Amount)
		Global.persistentCurrentPoints += CalcPoints() * delta
		
	if _can_upgrade():
		disabled = false
	else:
		disabled = true

func _can_upgrade() -> bool:
	return Global.persistentCurrentPoints >= CalculateCost()

func _on_click():
	if _can_upgrade():
		Upgrade()

func Upgrade():
	Global.persistentCurrentPoints -= CalculateCost()
	Global.AutoClickData[index].Amount += 1

func CalcPoints():
	return cps * Global.AutoClickData[index].Amount * pow(2, currentThresholdIndex)

func CalculateCost():
	if (Global.AutoClickData[index].Amount == 0):
		return baseCost
	
	var metThresh: int = 0
	var costMulti: int = 1
	
	for thresh in Global.multiThreshold:
		if (Global.persistentOwnedClickers >= thresh):
			metThresh += 1
			costMulti = pow(2, metThresh)
		else:
			break
	
	return ceil((baseCost * pow(Global.MULTIPLIER, Global.AutoClickData[index].Amount)) / costMulti)
	
