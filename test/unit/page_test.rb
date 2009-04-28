require File.dirname(__FILE__) + '/../test_helper'

class PageTest < ActiveSupport::TestCase
  context "A Page" do
    
    setup do
      @it = Factory(:page, :slug => 'it', :breadcrumb => 'it', :title => 'IT departament', 
                :content => 'it is bad department')
      @economy = Factory(:page, :slug => 'crisis', :breadcrumb => 'crisis', :title => 'Crisis', 
                    :content => 'more more ...')
      @economy.published!
      @country = Factory(:page, :slug => 'country', :breadcrumb => 'country', :title => 'New country', 
                    :content => 'more')
      @country.published!
    end
    
    should "should find only published" do
      @pages = Page.published 
      assert_contains @pages, @economy
      assert_contains @pages, @country
      
      assert_does_not_contain @pages, @it      
    end
    
    should "should find only crisis" do     
      @pages = Page.site_search('Crisis')
      
      assert_contains @pages, @economy
      assert @pages.size, 1
    end
    
    should "should find only a country" do  
      @pages = Page.site_search('country')

      assert_contains @pages, @country
      assert @pages.size, 1 
    end
    
    should "should find two result" do
      @pages = Page.site_search('more')
      
      assert_contains @pages, @economy
      assert_contains @pages, @country
      
      assert @pages.size, 2
    end
  
  end

end
