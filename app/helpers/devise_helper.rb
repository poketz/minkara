module DeviseHelper
  def bootstrap_alert(key)
    case key
    when "alert"
      "danger"
    when "notice"
      "dark"
    when "danger"
      "danger"
    when "primary"
      "primary"
    when "success"
      "success"
    end
  end
end
