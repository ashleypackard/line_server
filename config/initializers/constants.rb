# set the file path and max lines of the file on server start up
FILE_PATH = "#{Rails.root}/lib/assets/medium_text.txt"
MAX_LINES = File.open(FILE_PATH).each.count
