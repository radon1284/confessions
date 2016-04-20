class Base64EncodedFile
  def self.parse(string, file_name)
    StringIOWithFileName.new(
      Base64.decode64(string),
      file_name
    )
  end

  class StringIOWithFileName < StringIO
    attr_reader :original_filename

    def initialize(string, file_name)
      @original_filename = file_name
      super(string)
    end
  end
end
