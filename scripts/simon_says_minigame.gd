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

func make_random(n: int):
	ans = ""
	for i in range(n):
		ans += choices[randi_range(0, len(choices)-1)]

func next_round():
	can_click = false
	curr_round += 1
	if curr_round > rounds:
		print("Win")# TODO add win!
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
	if len(user_in) == len(ans):
		print("???")
		return
	if col != ans[len(user_in)-1]:
		print("???")
		return
	user_in += col
	if user_in == col:
		user_in = ""
		next_round()
