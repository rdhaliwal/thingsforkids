(->
  window.Financials or (window.Financials = {})

  Financials.init_card_fields = ->
    $('#card_number').keyup (e) ->
      if @value == @lastValue
        return
      caretPosition = @selectionStart
      sanitizedValue = @value.replace(/[^0-9]/gi, '')
      parts = []
      i = 0
      len = sanitizedValue.length
      while i < len
        parts.push sanitizedValue.substring(i, i + 4)
        i += 4
      i = caretPosition - 1
      while i >= 0
        c = @value[i]
        if c < '0' or c > '9'
          caretPosition--
        i--
      caretPosition += Math.floor(caretPosition / 4)
      @value = @lastValue = parts.join(' ')
      @selectionStart = @selectionEnd = caretPosition
      return

).call this
