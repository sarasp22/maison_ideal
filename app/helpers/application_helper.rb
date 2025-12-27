module ApplicationHelper
  def status_color(status)
    case status
    when 'pending' then 'warning'
    when 'confirmed' then 'success'
    when 'rejected' then 'danger'
    else 'secondary'
    end
  end
end
