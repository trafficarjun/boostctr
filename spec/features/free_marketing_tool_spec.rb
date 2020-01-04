require 'spec_helper'

feature "free marketing tool" do
  
  #visits the page first time
  #enters focus keyword and shop (product) url
  #views results
  #some results are updated in real time (if it takes longer to complete)
  #email lead form
  
  
  scenario "first time" do 
    visit seo_score_index_path
    fill_in "Enter focus keyword", with: "buy red shoes"
    fill_in "Enter page URL", with: "www.example.com/products/buy_red_shoes"
    click_button "Get Product Page Score"
    
    expect(page).to have_content("score")
    expect(page).to have_content("10")
    expect(page).to have_content("contain your primary keyword")
    
    #image alt text includes keyword
  end
end


