FactoryGirl.define do
  factory :photo do
    file { File.new(file_fixture("checkmark.png")) }
  end
end
