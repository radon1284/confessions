module FixtureHelpers
  def file_fixture_path(path)
    Rails.root.join("spec", "fixtures", path)
  end
end
