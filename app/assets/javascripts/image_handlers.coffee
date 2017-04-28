# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.getElementById('files').onchange = ->
  reader = new FileReader

  reader.onload = (e) ->
    # get loaded data and render thumbnail.
    document.getElementById('image').src = e.target.result
    return

  # read the image file as a data URL.
  reader.readAsDataURL @files[0]
  return
