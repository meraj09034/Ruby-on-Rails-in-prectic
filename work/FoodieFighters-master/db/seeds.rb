#
# Create the Food table and populate it with the data from the XML file found here:
#    https://explore.data.gov/Health-and-Nutrition/MyPyramid-Food-Raw-Data/b978-7txq
#    https://explore.data.gov/download/b978-7txq/XML
#
#  Schema is described in the file:  'DatasetFAQ.pdf'
#
require 'nokogiri'

f = File.open('db/Food_Display_Table.xml')
doc = Nokogiri::XML(f)
f.close

doc.css('Food_Display_Row').each do |node|
  children = node.children
  #puts children.inspect
  Food.create(
    food_code: children.css('Food_Code').inner_text,                          # string
    display_name: children.css('Display_Name').inner_text,                    # string
    portion_default: children.css('Portion_Default').inner_text.to_f,         # float
    portion_amount: children.css('Portion_Amount').inner_text.to_f,           # float
    portion_display_name: children.css('Portion_Display_Name').inner_text,    # string
    factor: children.css('Factor').inner_text.to_f,                           # float
    portion_increment: children.css('Increment').inner_text.to_f,             # float
    multiplier: children.css('Multiplier').inner_text.to_f,                   # float
    grains: children.css('Grains').inner_text.to_f,                           # float
    whole_grains: children.css('Whole_Grains').inner_text.to_f,               # float
    vegetables: children.css('Vegetables').inner_text.to_f,                   # float
    orange_vegetables: children.css('Orange_Vegetables').inner_text.to_f,     # float
    drkgreen_vegetables: children.css('Drkgreen_Vegetables').inner_text.to_f, # float
    starchy_vegetables: children.css('Starchy_vegetables').inner_text.to_f,   # float
    other_vegetables: children.css('Other_Vegetables').inner_text.to_f,       # float
    fruits: children.css('Fruits').inner_text.to_f,                           # float
    milk: children.css('Milk').inner_text.to_f,                               # float
    meats: children.css('Meats').inner_text.to_f,                             # float
    soy: children.css('Soy').inner_text.to_f,                                 # float
    drybeans_peas: children.css('Drybeans_Peas').inner_text.to_f,             # float
    oils: children.css('Oils').inner_text.to_f,                               # float
    solid_fats: children.css('Solid_Fats').inner_text.to_f,                   # float
    added_sugars: children.css('Added_Sugars').inner_text.to_f,               # float
    alcohol: children.css('Alcohol').inner_text.to_f,                         # float
    calories: children.css('Calories').inner_text.to_f,                       # float
    saturated_fats: children.css('Saturated_Fats').inner_text.to_f            # float
  )
end

=begin
<Food_Display_Row>
    <Food_Code>51401010</Food_Code>
    <Display_Name>Rye bread</Display_Name>
    <Portion_Default>2.00000</Portion_Default>
    <Portion_Amount>1.00000</Portion_Amount>
    <Portion_Display_Name>thin slice</Portion_Display_Name>
    <Factor>1.00000</Factor>
    <Increment>.50000</Increment>
    <Multiplier>.50000</Multiplier>
    <Grains>.76920</Grains>
    <Whole_Grains>.28280</Whole_Grains>
    <Vegetables>.00000</Vegetables>
    <Orange_Vegetables>.00000</Orange_Vegetables>
    <Drkgreen_Vegetables>.00000</Drkgreen_Vegetables>
    <Starchy_vegetables>.00000</Starchy_vegetables>
    <Other_Vegetables>.00000</Other_Vegetables>
    <Fruits>.00000</Fruits>
    <Milk>.00000</Milk>
    <Meats>.00000</Meats>
    <Soy>.00000</Soy>
    <Drybeans_Peas>.00000</Drybeans_Peas>
    <Oils>.01498</Oils>
    <Solid_Fats>3.40380</Solid_Fats>
    <Added_Sugars>.00000</Added_Sugars>
    <Alcohol>.00000</Alcohol>
    <Calories>51.80000</Calories>
    <Saturated_Fats>.12600</Saturated_Fats>
  </Food_Display_Row>
=end