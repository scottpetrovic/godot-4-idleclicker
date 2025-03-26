extends Label

var pps : float = 0.0
@onready var auto_click_column: VBoxContainer = $"../AutoClickColumn"
@onready var pps_timer: Timer = $"../../PPSTimer"

func _ready() -> void:
	pps_timer.start()
	pps_timer.timeout.connect(_timer_timeout)


func _timer_timeout() -> void:
	pps = 0.0 # reset points per second
	var autoClicks =  auto_click_column.get_children()
	for ac in autoClicks:
		
		if ac.has_method("CalcPoints"):
			pps += ac.CalcPoints()

	text = Global.number_display(pps) + " auto points/sec"
