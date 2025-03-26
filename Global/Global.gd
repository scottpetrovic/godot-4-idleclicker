extends Node

# Array of Dictionaries containing the Data for all AutoClickers
# Basic Structure is:
# {"BaseCost", "CPS"}
# This will mean we will have 4 levels of auto-clickers we can level up
var AutoClickData = \
	[
		{ "BaseCost": 50, "CPS": 1, "Amount": 0},
		{ "BaseCost": 500, "CPS": 10, "Amount": 0},
		{ "BaseCost": 5000, "CPS": 100, "Amount": 0},
		{ "BaseCost": 50000, "CPS": 1000, "Amount": 0}
	]

# auto clicker scale for how leveling works
# first auto clicker = getting level 1 will cost 50. level 2 costs 50 * 1.06. Further levels compound with 1.06
# second auto clicker = getting level 1 costs 500
const MULTIPLIER : float = 1.06

# this works with the cost multiplier to slowly make things more costly
var multiThreshold = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1200]


# Persistent data to be held in savefile and control game flow

# total points counter we have accumulated
var currentPoints : int = 0
var persistentCurrentPoints : float = 0

# manual clicker that we are doing clicking. Start at level 1
var ownedClickers : int = 1
var persistentOwnedClickers : int = 1 

# automatic clickers that work for us
var ownedAutos: int = 0
var persistentOwnedAutos: int = 0


# adds comma separators for thousands 
func number_display(n: float) -> String:
	var str: String = str(int(round(n)))
	var result = ""
	var count = 0

	for i in range(str.length() - 1, -1, -1):
		result = str[i] + result
		count += 1
		if count == 3 and i != 0:
			result = "," + result
			count = 0

	return result
