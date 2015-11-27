#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require_tree .

$(document).ready ->
  $(".new_gradient_form").on("ajax:success", (e, data, status, xhr) ->
    $(e.target).find("input,button").attr("disabled", "disabled")
    $(e.target).find("button[type=submit]")
      .removeClass("btn-primary")
      .addClass("btn-success")
      .html("<span class=\"glyphicon glyphicon-success\"/> Saved")

  ).on "ajax:error", (e, xhr, status, error) ->
    $(e.target).replaceWith(xhr.responseText)
