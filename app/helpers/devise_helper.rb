module DeviseHelper
  def bootstrap_alert(key)
    case key
    when "alert"
      "danger"
    when "notice"
      "dark"
    when "error"
      "danger"
    when "success"
      "primary"
    end
  end
end