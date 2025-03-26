extends Label

func _process(_delta):
	text = "Points: " + Global.number_display(Global.persistentCurrentPoints)
