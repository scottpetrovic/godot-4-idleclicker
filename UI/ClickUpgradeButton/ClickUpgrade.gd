extends TextureButton

var baseCost: int = 10

func _ready():
	pressed.connect(_on_click)

func _process(_delta):
	$Label.text = "Upgrade Click Cost: " + str(CalculateCost())
	
	# if we don't have enough to upgrade, disable button
	if _can_upgrade() == true:
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
	Global.persistentOwnedClickers += 1


func CalculateCost():	
	if (Global.persistentOwnedClickers == 1):
		return baseCost
	
	var metThresh: int = 0
	var costMulti: int = 1

	for thresh in Global.multiThreshold:
		if (Global.persistentOwnedClickers >= thresh):
			metThresh += 1
			costMulti = pow(2, metThresh)
		else:
			break

	return ceil((baseCost * pow(Global.MULTIPLIER, Global.persistentOwnedClickers) / costMulti))
