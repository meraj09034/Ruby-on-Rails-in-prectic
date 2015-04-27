module ErrorHelper
  # A simple way to show error messages for the current sms resource. If you need
  # to customize this method, you can either overwrite it in your application helpers or
  # copy the views to your application.
  #
  # This method is intended to stay simple and it is unlikely that we are going to change
  # it to add more behavior or options.
  def error_messages! model_name
    return "" if model_name.errors.empty?
                            #raise  model_name.errors
    messages = model_name.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => model_name.errors.count,
                      :resource => model_name.class.model_name.human.downcase)

    html = <<-HTML

<div class="alert alert-danger alert-dismissible fade in" role="alert">
<h4>#{sentence}</h4>
<ul class="list-inline">
<li>#{messages}</li>
</ul>
</div>

<!--div id="error_explanation"></div-->
    HTML

    html.html_safe
  end
end