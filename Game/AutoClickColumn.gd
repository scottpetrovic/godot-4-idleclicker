extends Node

const AutoClicker = preload("res://UI/AutoClickerButton/AutoClicker.tscn")

func _process(_delta):
	
	if (Global.AutoClickData.size() - 1 >= Global.persistentOwnedAutos):
		if (Global.persistentCurrentPoints >= Global.AutoClickData[Global.persistentOwnedAutos].BaseCost):
			if (Global.AutoClickData[Global.persistentOwnedAutos].Amount == 0):
				self.add_child(AutoClicker.instantiate())
