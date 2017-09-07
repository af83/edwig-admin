module ErrorsHelper

  def errors_full_messages(errors)
    content_tag :ul, class: "list-group" do
      errors.map do |attribute, messages|
        messages.map do |message|
          content_tag :li, "#{attribute}: #{message}", class: "alert alert-danger"
        end.join
      end.join.html_safe
    end
  end

end
