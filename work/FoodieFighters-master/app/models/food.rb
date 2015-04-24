class Food < ActiveRecord::Base
  paginates_per 25
  
  def Food.display_page( page )
    order(:display_name).page( page )
  end
end
