class ShippingDuration < ActiveHash::Base
  self.data = [ 
    {id: 0, duration: '-'},
    {id: 1, duration: '1~2日で発送'}, 
    {id: 2, duration: '2~3日で発送'},
    {id: 3, duration: '4~7日で発送'},
  ]
end