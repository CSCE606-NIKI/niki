module ApplicationHelper
    def flash_class(type)
      case type
      when 'notice'
        'alert alert-success'
      when 'alert', 'error'
        'alert alert-danger'
      else
        'alert alert-info'
      end
    end
  end
  
