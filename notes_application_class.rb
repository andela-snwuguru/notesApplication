class NotesApplication

  def initialize author
    @author = author
    @notes = []
  end

	def create note_content
		return nil if note_content.length == 0
		@notes << {author: @author,note: note_content,id: @notes.length}
		@notes.length - 1
	end

	def list
		printLine
		return puts "No note found" if @notes.length == 0
		@notes.each{ |note|
			print note
		}
		
	end

	def get note_id
		return 'Note ID must be an Integer' if !note_id.is_a? Integer
		return @notes[note_id] if @notes[note_id] != nil
		"Invalid Note ID"
	end

	def search search_text
		if !search_text.is_a? Integer
			return false if search_text.length == 0
		end
		result = @notes.select{|note| note[:note].match(/^?#{search_text}/)}
		printLine
		puts "Showing results for search <#{search_text}>"
		printLine
		puts "No result found" if result.length == 0
		result.each{|note| print note}
		true
	end

	def delete note_id
		return 'Note ID must be an Integer' if !note_id.is_a? Integer
		@notes.delete_at(note_id) if @notes[note_id] != nil
	end

	def edit note_id, note_content
		return 'Note ID must be an Integer' if !note_id.is_a? Integer
		return false if @notes[note_id] == nil || note_content.length == 0
		@notes[note_id] = {author: @author,note: note_content,id:note_id}
		true
	end

	def get_notes
		@notes
	end

	#Utility methods
	def print note
		return puts 'Invalid note records' if !note.is_a? Hash
		puts "Note ID: #{note[:id]}"
		puts "#{note[:note]}"
		puts "By Author #{note[:author]}"
		printLine
	end

	def printLine
		puts "--------------------------------------------------------------------"
	end
end