module ApplicationHelper
  # CSS class for a filter tab; "active" when it is the selected filter.
  def filter_class(current_status, tab_status)
    current_status == tab_status ? "filter active" : "filter"
  end

  def format_time(time)
    time.utc.strftime("%d %b %Y, %H:%M UTC")
  end
end
