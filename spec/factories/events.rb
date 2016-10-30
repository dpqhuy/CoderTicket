FactoryGirl.define do
  factory :event do
    starts_at DateTime.now
	extended_html_description "MyString"
  end

end
