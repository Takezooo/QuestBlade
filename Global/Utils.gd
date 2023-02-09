extends Node

const SAVE_PATH: String = "D:\\DaveJornales\\Documents\\test\\QBv0.0.1_Data\\savegame.bin"
const SAVE_PASS: String = "password"

func get_file(is_write: bool):
	var save_game: File = File.new()
	var password: String = SAVE_PASS
	
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		password = OS.get_unique_id()
		
	if is_write:
		save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, password)
	else:
		if not save_game.file_exists(SAVE_PATH):
			return
		save_game.open_encrypted_with_pass(SAVE_PATH, File.READ, password)
	return save_game
	
func save_game():
	var save_game: File = get_file(true)
	var data: Dictionary = {
		"Gender": Game.Gender,
		"PlayerSelected": Game.PlayerSelected,
		"FirstLaunch": Game.FirstLaunch,
	}
	save_game.store_line(to_json(data))
	save_game.close()
	
func load_game():
	var save_game: File = get_file(false)
	if not save_game:
		return
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		if current_line:
			Game.Gender = current_line["Gender"]
			Game.PlayerSelected = current_line["PlayerSelected"]
			Game.FirstLaunch = current_line["FirstLaunch"]
			
	save_game.close()
