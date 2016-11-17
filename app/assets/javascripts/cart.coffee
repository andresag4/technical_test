# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  set_cart_buttons_function = ->
    $(".edit-cart-button").on "click", ->
      url = $(this).data("url")
      $.ajax(
        url: url
        type: "PUT"
        dataType: "json"
        timeout: 1500
      ).success (data) ->
        $('#subtotal').text(data.subtotal)
        $('#tax').text(data.tax)
        $('#total').text(data.total)

        if data.status == 'remove_all'
          $('#product_' + data.product_id).remove()
        else
          if $('#product_' + data.product_id + '_quantity').length
            $('#product_' + data.product_id + '_quantity').text(data.quantity)
          else
            url = '/get_row/' + data.product_id
            $.get url, () ->
              set_cart_buttons_function()
              return
          return
      return
    return

  set_cart_buttons_function()
  return
