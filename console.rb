require('pry')
require_relative('models/property_tracker')

Property.delete_all()

property1 = Property.new( {'address' => 'Castle View Terrace',
  'value' => '500',
  'number_of_bedrooms' => '4',
  'year_built' => '1970',
  'buy_let_status' => 'For sale',
  'square_footage' => '1600',
  'build_semi_flat_etc' => 'Detached'
  } )

  property2 = Property.new( {'address' => 'Lochy Rise',
    'value' => '40',
    'number_of_bedrooms' => '3',
    'year_built' => '2014',
    'buy_let_status' => 'For sale',
    'square_footage' => '800',
    'build_semi_flat_etc' => 'Semi Detached'
    } )

  property1.save
  property2.save
  check_properties = Property.all

  property1.address = "CodeClan"
  property1.update

property2.delete
