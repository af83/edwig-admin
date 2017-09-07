module ErrorsHelper

  def errors_full_messages(errors)
    content_tag :ul do
      errors.map do |attribute, messages|
        messages.map do |message|
          content_tag :li, "#{attribute}: #{message}"
        end.join
      end.join.html_safe
    end
  end

end
