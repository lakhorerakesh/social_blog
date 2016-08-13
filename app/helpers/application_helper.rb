module ApplicationHelper
  def header(text)
    content_for(:header) { text.to_s }
  end

  def full_title(page_title = '')
    base_title = "Blog App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def ajax_flash(div_id)
    response = ""
    flash_div = ""

    flash.each do |name, msg|
      if msg.is_a?(String)
        flash_div = "<div class=\"alert alert-#{name == :notice ? 'success' : 'error'} ajax_flash\"><a class=\"close\" data-dismiss=\"alert\">&#215;</a> <div id=\"flash_#{name == :notice ? 'notice' : 'error'}\">#{h(msg)}</div> </div>"
      end 
    end

    response = "$('.ajax_flash').remove();
                $('#{div_id}').prepend('#{flash_div}');"
    response.html_safe
  end

=begin
def authenticate!
    unless current_user
      render 'authenticate.js.erb'
    end
  end
=end

end

