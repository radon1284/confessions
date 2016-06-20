FactoryGirl.define do
  factory :article do
    slug "janki-method"
    title "Janki Method"
    body %Q{## Intro
            This is my story about learning to code.
    }
  end
end
