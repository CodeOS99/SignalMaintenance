extends Control

var can_click: bool = false
var user_in := ""
var ans := ""
var choices := "rgbv"
var rounds := 3
var curr_round := 0
@onready var c_btn_map = {
	"r": $HBoxContainer/RedButton,
	"g": $HBoxContainer/GreenButton,
	"b": $HBoxContainer/BlueButton,
	"v": $HBoxContainer/VioletButton
}

func reset():
	can_click = false
	user_in = ""
	ans = ""
	curr_round = 0

func make_random(n: int):
	ans = ""
	for i in range(n):
		ans += choices[randi_range(0, len(choices)-1)]

func next_round():
	can_click = false
	curr_round += 1
	if curr_round > rounds:
		$"../SignalResolved".visible = true
		$".".visible = false
		Globals.is_signal = false
		$"..".resolved = true
		Globals.people_helped += 1
	make_random(curr_round)
	for c in ans:
		c_btn_map[c].flash()
		await c_btn_map[c].finished_flash
	can_click = true

func start():
	next_round()

func _process(delta: float) -> void:
	if visible and curr_round == 0:
		start()

func add(col):
	if col != ans[len(user_in)]:
		$"../TaskFailed".visible = true
		$".".visible = false
		$"..".failed = true
		return
	user_in += col
	if user_in == ans:
		user_in = ""
		next_round()
