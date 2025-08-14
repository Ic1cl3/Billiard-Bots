extends Control
## Script for the main menu UI.
class_name mainMenu

@onready var playerOneSelect = $playerOneSelect ## Access to player one option menu.
@onready var playerOneLoadBotButton = $playerOneSelect/loadBotButton ## Access to player one bot load button.
@onready var playerOnePathLabel = $playerOneSelect/loadBotButton/path ## Access to the player one bot path label.
@onready var playerOneFileDialogOpen = $playerOneSelect/fileDialogOpen ## Access to file dialog to be used for loading player one bots.
@onready var playerTwoSelect = $playerTwoSelect ## Access to player two option menu.
@onready var playerTwoLoadBotButton = $playerTwoSelect/loadBotButton ## Access to player two bot load button.
@onready var playerTwoPathLabel = $playerTwoSelect/loadBotButton/path ## Access to the player two bot path label.
@onready var playerTwoFileDialogOpen = $playerTwoSelect/fileDialogOpen ## Access to file dialog to be used for loading player two bots.
@onready var runScriptWarning = $runScriptWarning ## Access to the "Run your bot!" warning popup node.
@onready var notLoadedAIWarning = $notLoadedAIWarning ## Access to the "AI not loaded!" warning popup node.
@onready var sameBotLoadedWarning = $sameBotLoadedWarning ## Access to the "Same AI loaded!" warning popup node.
@onready var roundsSelect = $roundsSelect ## Access to the number of rounds selector.


var dontWarnMeAgain : bool = false ## Tracks whether the user has check "don't warn me again" in the "run bot" warning popup.


func _process(_delta: float) -> void:
	playerOneLoadBotButton.visible = playerOneSelect.selected == 3 # Hides the bot select button if AI is not chosen as player.
	playerTwoLoadBotButton.visible = playerTwoSelect.selected == 3
	if botManager.botOnePath == "": # Manage bot loading button text
		playerOneLoadBotButton.text = "Load\nBot"
	else:
		playerOneLoadBotButton.text = "Bot\nLoaded"
	if botManager.botTwoPath == "":
		playerTwoLoadBotButton.text = "Load\nBot"
	else:
		playerTwoLoadBotButton.text = "Bot\nLoaded"
	playerOnePathLabel.text = botManager.botOnePath
	playerTwoPathLabel.text = botManager.botTwoPath


func _on_p1_load_bot_button_pressed() -> void:
	playerOneFileDialogOpen.file_mode = 2 # Open folder
	playerOneFileDialogOpen.current_dir = ""
	playerOneFileDialogOpen.title = "Select a Folder"
	playerOneFileDialogOpen.show()


func _on_p1_file_dialog_open_dir_selected(dir: String) -> void:
	if dir != botManager.botTwoPath: # Prevents bot from fighting itself.
		botManager.openBot(dir, 0)
		if not dontWarnMeAgain: # Warns user to run bot script.
			runScriptWarning.show()
	else:
		sameBotLoadedWarning.show()


func _on_p2_load_bot_button_pressed() -> void:
	playerTwoFileDialogOpen.file_mode = 2 # Open folder.
	playerTwoFileDialogOpen.current_dir = ""
	playerTwoFileDialogOpen.title = "Select a Folder"
	playerTwoFileDialogOpen.show()


func _on_p2_file_dialog_open_dir_selected(dir: String) -> void:
	if dir != botManager.botOnePath: # Prevents bot from fighting itself.
		botManager.openBot(dir, 1)
		if not dontWarnMeAgain: # Warns user to run bot script.
			runScriptWarning.show()
	else:
		sameBotLoadedWarning.show()


func _on_run_script_warning_close_requested() -> void:
	runScriptWarning.hide()
	notLoadedAIWarning.hide()
	sameBotLoadedWarning.hide()


func _on_dontwarnmeagain_toggled(toggled_on: bool) -> void:
	dontWarnMeAgain = toggled_on


func _on_begin_button_pressed() -> void:
	if not ((playerOneSelect.selected == 3 and botManager.botOnePath == "") or (playerTwoSelect.selected == 3  and botManager.botTwoPath == "")): # Warns and does not proceed if bot is selected for play but not loaded.
		var gameStartNode : TextureRect = load("res://assets/gameStart/gameStart.tscn").instantiate()
		gameStartNode.playerOne = playerOneSelect.selected
		gameStartNode.playerTwo = playerTwoSelect.selected
		gameStartNode.playingTo = roundsSelect.value
		add_child(gameStartNode)
	else:
		notLoadedAIWarning.show()
