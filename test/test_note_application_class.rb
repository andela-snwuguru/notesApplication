require_relative '../src/notes_application_class.rb'
require "spec_helper" 

RSpec.describe "NotesApplication" do

  describe "Case for create method" do

    it "create method should not create empty note" do
      note = NotesApplication.new("user")
      response = note.create('')
      expect(response).to eq nil
    end

    it "create method returns the created note id" do
      note = NotesApplication.new("user")
      response = note.create('hello world')
      expect(response).to eq 0
    end

    it "check create method for false positive" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.create('another hello world')
      expect(response).to eq 1
    end

  end

  describe "Case for get method" do

    it "get method does not fail with invalid note id" do
      note = NotesApplication.new("user")
      response = note.get(0)

      expect(response.is_a? String).to eq true
    end

    it "get methods returns Hash" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.get(0)
      expect(response.is_a? Hash).to eq true
    end

    it "check get method for false positive" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.get(0)
      expect(response[:note] == 'hello world').to eq true
    end

    it "get methods handles invalid data type" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.get('0')
      expect(response.is_a? String).to eq true
    end

  end

  describe "Case for search method" do
    it "search methods returns false on empty string" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.search('')
      expect(response).to eq false
    end

    it "search methods searches integer" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.search(1)
      expect(response).to eq true
    end
  end

  describe "Case for delete method" do
    it "delete methods handles invalid data type" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.delete('0')
      expect(response.is_a? String).to eq true
    end

    it "delete methods returns nil on invalid note id" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.delete(1)
      expect(response).to eq nil
    end

    it "delete methods returns deleted hash" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.delete(0)
      expect(response.is_a? Hash).to eq true
    end

    it "check for false positive" do
      note = NotesApplication.new("user")
      note.create('hello world')
      note.create('another hello world')
      note.delete(0)
      response = note.get_notes
      expect(response.length).to eq 1
    end

    it "delete methods handles empty string" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.delete('')
      expect(response.is_a? String).to eq true
    end
  end


  describe "Case for edit method" do
    it "edit methods handles note id invalid data type" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.edit('0','new content')
      expect(response.is_a? String).to eq true
    end

    it "edit methods handles empty note content" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.edit(0,'')
      expect(response).to eq false
    end

    it "edit methods returns false on invalid note id" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.edit(1,'new content')
      expect(response).to eq false
    end

    it "edit methods returns true when successfull" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.edit(0,'new content')
      expect(response).to eq true
    end

    it "check edit method for false positive" do
      note = NotesApplication.new("user")
      note.create('hello world')
      response = note.edit(0,'new content')
      data = note.get(0)
      expect(response && data[:note] == 'new content').to eq true
    end
  end


  describe "Case for list method" do
    it "list method return nil when note is empty" do
      note = NotesApplication.new("user")
      response = note.list()
      expect(response).to eq nil
    end

  end

  describe "Case for exceptions" do
    it "constructor require argument" do
      expect { NotesApplication.new() }.to raise_error(ArgumentError)
    end

    it "get method require argument" do
      note = NotesApplication.new('user')
      expect { note.get() }.to raise_error(ArgumentError)
    end

    it "edit method require 2 arguments" do
      note = NotesApplication.new('user')
      expect { note.edit(0) }.to raise_error(ArgumentError)
    end

    it "delete method require arguments" do
      note = NotesApplication.new('user')
      expect { note.delete() }.to raise_error(ArgumentError)
    end

    it "create method require arguments" do
      note = NotesApplication.new('user')
      expect { note.create() }.to raise_error(ArgumentError)
    end
  end

end