require "rails_helper"

describe FindRelatedArticles do
  let!(:service) { FindRelatedArticles.new(2) }
  let!(:main_article) do
    FactoryGirl.create(:article, slug: "1", all_tags: "marketing, engagement")
  end

  context "when there are no other articles" do
    it "does not return the same article" do
      result = service.call(main_article)
      expect(result).to eq []
    end
  end

  context "when there are some articles, but from different tag" do
    let!(:other_article) { FactoryGirl.create(:article, slug: "2") }

    it "returns these articles as a replacement" do
      result = service.call(main_article)
      expect(result).to eq [other_article]
    end
  end

  context "when there are some articles from the same tag" do
    let!(:marketing_article) do
      FactoryGirl.create(:article, slug: "2", all_tags: "marketing")
    end
    let!(:other_article) { FactoryGirl.create(:article, slug: "3") }

    it "gives them priority" do
      result = service.call(main_article)
      expect(result).to eq [marketing_article, other_article]
    end
  end

  context "when there are more matching articles than the limit" do
    let!(:marketing_article) do
      FactoryGirl.create(:article, slug: "2", all_tags: "marketing")
    end
    let!(:engagement_article) do
      FactoryGirl.create(:article, slug: "3", all_tags: "engagement")
    end
    let!(:other_article) { FactoryGirl.create(:article, slug: "4") }

    it "returns no more articles than the limit" do
      result = service.call(main_article)
      expect(result.size).to eq 2
    end
  end
end
