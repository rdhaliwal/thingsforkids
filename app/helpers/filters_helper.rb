module FiltersHelper
  def icon_class value
    return "fa fa-thumb-tack poi-icon-color" if value == 1
    return "fa fa-graduation-cap classes-icon-color" if value == 2
    return "fa fa-rocket fa-2 playcenter-icon-color" if value == 3
    return "fa fa-home childcare-icon-color" if value == 4
    return "fa fa-coffee fa-2 kidscafes-icon-color" if value == 5
    "fa fa-tree parks-icon-color" if value == 6
  end
end
