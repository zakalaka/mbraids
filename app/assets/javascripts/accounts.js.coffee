# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $.widget "ui.combobox",
    _create: ->
      removeIfInvalid = (element) ->
        value = $(element).val()
        matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex(value) + "$", "i")
        valid = false
        select.children("option").each ->
          if $(this).text().match(matcher)
            @selected = valid = true
            false

        unless valid

          # remove invalid value, as it didn't match anything
          $(element).val("").attr("title", value + " didn't match any item").tooltip "open"
          select.val ""
          setTimeout (->
            input.tooltip("close").attr "title", ""
          ), 2500
          input.data("ui-autocomplete").term = ""
      input = undefined
      that = this
      wasOpen = false
      select = @element.hide()
      selected = select.children(":selected")
      value = (if selected.val() then selected.text() else "")
      wrapper = @wrapper = $("<span>").addClass("ui-combobox").insertAfter(select)
      input = $("<input>").appendTo(wrapper).val(value).attr("title", "").addClass("ui-state-default ui-combobox-input").autocomplete(
        delay: 0
        minLength: 0
        source: (request, response) ->
          matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i")
          response select.children("option").map(->
            text = $(this).text()
            if @value and (not request.term or matcher.test(text))
              label: text.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(request.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>")
              value: text
              option: this
          )

        select: (event, ui) ->
          ui.item.option.selected = true
          that._trigger "selected", event,
            item: ui.item.option


        change: (event, ui) ->
          removeIfInvalid this  unless ui.item
      ).addClass("ui-widget ui-widget-content ui-corner-left")
      input.data("ui-autocomplete")._renderItem = (ul, item) ->
        $("<li>").append("<a>" + item.label + "</a>").appendTo ul

      $("<a>").attr("tabIndex", -1).attr("title", "Show All Items").tooltip().appendTo(wrapper).button(
        icons:
          primary: "ui-icon-triangle-1-s"

        text: false
      ).removeClass("ui-corner-all").addClass("ui-corner-right ui-combobox-toggle").mousedown(->
        wasOpen = input.autocomplete("widget").is(":visible")
      ).click ->
        input.focus()

        # close if already visible
        return  if wasOpen

        # pass empty string as value to search for, displaying all results
        input.autocomplete "search", ""

      input.tooltip tooltipClass: "ui-state-highlight"

    _destroy: ->
      @wrapper.remove()
      @element.show()


$ ->
  $("#check").button()

  $("input[type=submit], button").button()

  $("form input[type=text], textarea, input[type=password]")
    .each ->
      if(this.value)
        $(this).prev().hide()
    .focus ->
      $(this).prev().hide()
    .blur ->
      if(!this.value)
        $(this).prev().show()

  $("#radio").buttonset()
  $("#combobox").combobox()
