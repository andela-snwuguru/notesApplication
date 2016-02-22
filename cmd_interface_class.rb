require_relative 'notes_application_class.rb'
module BootCamp
	class CommanLineInterface
		
		def initialize
			welcome
			start_note_app
		end

		def print_line
			puts '---------------------------------------------------------------------------------'
		end

		def print_line_space
			puts '---------------------                                    ------------------------'
		end

		def print_text_space text
			puts "---------------------         #{text}      ------------------------"
		end

		def welcome
			print_line
			print_line
			print_line
			print_line_space
			print_line_space
			print_text_space 'RUBY NOTE APPLICATION'
			print_line_space
			print_line_space
			print_line
			print_line
			print_line
			puts "			Follow the prompts to use application"
			print_line
		end

		def instruction
			print_line
			print_text_space " Usage instructions/process commands"
			puts "create  -  Create new note"
			puts "list    -  List all notes"
			puts "edit	  -  Edit existing note"
			puts "delete  -  Delete existing note"
			puts "search  -  Search existing note"
			puts "help	  -  Show instruction/process commands"
			puts "quit	  -  Quit application"
			print_line
			print_line
		end

		def start_note_app
			@author = request_author
			start_note
		end

		def start_note
			@app = NotesApplication.new(@author)
			request_process
		end

		def request_author
			puts 'Enter Author Name: '
			author = gets.chomp
			return author if author.length > 0
			
			while author.length == 0
				puts 'Author name is required'
				request_author
				break;
			end
		end

		def request_process
			print_line
			print_line
			print_text_space "welcome #{@author}"
			print_line
			instruction
			
			
			while true
				print_line
				puts "Enter a process command:"
				command = gets.chomp.downcase
				case command
				when "create"
					request_create
				when 'edit'
					request_edit
				when 'list'
					request_list
				when 'search'
					request_search
				when 'delete'
					request_delete
				when 'help'
					instruction
				when 'quit'
					break
				else
					print_text_space "<#{command}> is not a valid command"
					instruction
				end
			end
			puts "Thank you for using note application"
			print_line
		end

		def request_create
			print_line
			print_line
			
			while true
				puts "Enter note content:"
				note_content = gets.chomp
				if note_content.length == 0
					puts "Note Content cannot be blank"
					print_line
				else
					note_id = @app.create note_content
					puts "Note ID: #{note_id} successfully created"
					break
				end
			end

		end

		def request_list
			print_line
			print_line
			print_text_space 'ALL NOTES'
			print_line
			print_line
			@app.list
			print_line
		end

		def request_search
			print_line
			
			while true
				puts "Enter Search Text:"
				search_text = gets.chomp
				if search_text.length == 0
					puts "Search text cannot be blank"
					print_line
				else
					@app.search search_text
					print_line
					break
				end
			end

		end


		def request_edit
			print_line
			return puts 'Note is empty' if @app.get_notes.length == 0
			
			while true
				request_list
				puts "Enter Note ID from the list above:"
				note_id = gets.chomp
				if note_id.length == 0
					puts "Note ID is required"
					print_line
				else
					print_line
					while true
						puts "Enter note content:"
						note_content = gets.chomp
						if note_content.length == 0
							puts "Note Content cannot be blank"
							print_line
						else
							print_line
							result = @app.edit note_id.to_i,note_content
							puts "Note ID: #{note_id} successfully updated" if result
							puts "Note ID: #{note_id} is invalid" if !result
							print_line
							break
						end
					end
					
				end
				break
			end
		end

		def request_delete 
			print_line
			return puts 'Note is empty' if @app.get_notes.length == 0
			
			while true
				request_list
				puts "Enter Note ID from the list above:"
				note_id = gets.chomp
				if note_id.length == 0
					puts "Note ID is required"
					print_line
				else
					print_line
					result = @app.delete note_id.to_i
					if result.is_a? Hash
						puts "Note ID:#{note_id} successfully deleted" 
						break
					else
						puts 'Invalid Note ID'
					end
					print_line
					
				end
			end

		end

	end

end