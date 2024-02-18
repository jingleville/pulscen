class CustomRender < Redcarpet::Render::HTML
  def block_quote(quote)
    %(<blockquote class="my-custom-class">#{quote}</blockquote>)
  end
end

module PagesHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true, 
        fenced_code_blocks: true
    }
    Redcarpet::Markdown.new(CustomRender, options).render(text).html_safe
  end		
end