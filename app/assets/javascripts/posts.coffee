# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  new ImageTrimmer()

class ImageTrimmer
  constructor: ->
    $('#trimbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#post_trim_x').val(coords.x)
    $('#post_trim_y').val(coords.y)
    $('#post_trim_w').val(coords.w)
    $('#post_trim_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#preview').css
        width: Math.round(100/coords.w * $('#trimbox').width()) + 'px'
        height: Math.round(100/coords.h * $('#trimbox').height()) + 'px'
        marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
        marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'