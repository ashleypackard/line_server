# The line server controller takes a number as a parameter
# Uses that number to find a specific line of text from a static file
# For testing purposes the file is lib/assets/medium_text which is ~1.5gb
# The constants referenced here are located in config/initializers/constants.rb
# If the line number received is out of scope of the file a 413 is returned with an error
# Otherwise the file is opened and the specified line of text is retrieved and returned with status 200
# Text from the past 5 minutes are stored in cache to provide faster lookup.
# If the requested line of text has been looked up in the past 5 minutes
# it's retrieved from cache otherwise it's read from the file.


# Sample request: GET http://localhost:3000/api/v1/lines/332809
# Response:
# {
#     "status": "ok",
#     "line_number": 332809,
#     "line_text": "This is some text.\n"
# }
class API::V1::LinesController < ActionController::API
	def show
    line_number = params[:id].to_i

    if line_number > MAX_LINES
      render status: 413, json: {
        "errors": {
          "line_number": "out of range"
        }
      }
    else
  		render json: {
        "status": "ok",
        "line_number": line_number,
        "line_text": get_line_text(line_number)
      }
    end
	end

  private

  def get_line_text(line_number)
    text = Rails.cache.read(line_number)

    unless text
      text = get_line_text_from_file(line_number)
      Rails.cache.write(line_number, text, expires_in: 5.minutes.to_i)
    end

    text
  end

  def get_line_text_from_file(line_number)
    File.open(FILE_PATH) do |file|
      file.each_line.lazy.drop(line_number-1).first
    end
  end
end
