module ApplicationHelper
  # PageHeader builder
  def pageheader pageicon, pagetitle, desc = nil, meta = nil, mainaction = nil, &block

    firstRow = content_tag :div, '', class: 'row' do
      # Left part with pageicon & pagetitle & desc
      left = content_tag :div, '', class: 'col-lg-9 col-md-8 col-sm-7 col-xs-7' do
        picon = content_tag :div, '', class: 'page-icon' do
          content_tag :span, '', class: "fa fa-lg fa-#{pageicon}"
        end
        ptitle = content_tag :div, '', class: 'page-title' do
          content_tag :h1, pagetitle, title: desc
        end

        picon + ptitle
      end
      # Right part with meta & mainaction
      right = content_tag :div, '', class: 'col-lg-3 col-md-4 col-sm-5 col-xs-5 text-right' do
        content_tag :div, '', class: 'page-action' do
          a = content_tag :div, meta.try(:html_safe), class: 'small'
          b = mainaction.try(:html_safe)

          a + b
        end
      end

      left + right
    end

    content_tag :div, '', class: 'page_header' do
      content_tag :div, '', class: 'container-fluid' do
        if block_given?
          firstRow + capture(&block)
        else
          firstRow
        end
      end
    end
  end

  # Definition list
  def definition_list title, test
    return unless test.present?

    head = content_tag(:div, title, class: 'dl-head')

    body = content_tag :div, class: 'dl-body' do
      cont = []
      test.map do |k, v|
        cont << content_tag(:div, k, class: 'dl-term')
        cont << content_tag(:div, v, class: 'dl-def')
      end
      cont.join.html_safe
    end

    content_tag :div, '', class: 'definition-list' do
      head + body
    end
  end

end
