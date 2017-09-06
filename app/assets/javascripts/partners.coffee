$ ->
  $('#add_partner_setting').on 'click', ->
    new_index = Date.now()

    fields = $('#partner_setting_template').children().clone(true)
    fields.children().each (index, node) ->
      node = $(node)
      if node.is('input')
        node.attr('disabled', false).attr 'name', (index, name) -> name.replace('index', new_index)

    fields.insertBefore this

  $('.remove_partner_setting').on 'click', ->
    $(this).parent().prev().remove()
    $(this).remove()
