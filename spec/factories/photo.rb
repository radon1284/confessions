FactoryGirl.define do
  factory :photo do
    file { File.new(file_fixture_path("checkmark.png")) }
  end
end
