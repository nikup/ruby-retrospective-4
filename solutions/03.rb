module RBFS
  TYPES = {
    "TrueClass" => :boolean,
    "FalseClass" => :boolean,
    "NilClass" => :nil,
    "Fixnum" => :number,
    "Bignum" => :number,
    "Float" => :number,
    "Complex" => :number,
    "String" => :string,
    "Symbol" => :symbol,
  }

  class File
    attr_reader :data_type, :data

    def initialize(data = nil)
      @data  = data
      @data_type = TYPES[data.class.name]
    end

    def data=(data)
      @data  = data
      @data_type = TYPES[data.class.name]
    end

    def serialize
      data_type.to_s + ':' + data.to_s
    end

    def self.parse(string_data)
    end
  end

  class Directory
    attr_reader :files, :directories

    def initialize
      @files = {}
      @directories = {}
    end

    def add_file(name, file = File.new)
      @files[name] = file
    end

    def add_directory(name, directory = Directory.new)
      @directories[name] = directory
    end

    def [](name)
      @directories[name] || @files[name]
    end

    def serialize
      serialized = ""
      serialized += serialize_array @files
      serialized += serialize_array @directories
    end

    def serialize_array(array)
      serialized = array.size.to_s + ':'
      array.each  do |name, value|
        serialized += name.to_s + ':'
        serialized += value.serialize.size.to_s + ':'
        serialized += value.serialize.to_s
      end

      serialized
    end

    def self.parse(string_data)
    end
  end
end