class LinkDecorator < Draper::Decorator
  delegate_all

  def subs_list
    self.subs.map do |sub|
      h.link_to(sub.name, h.sub_url(sub))
    end.join(', ').html_safe
  end
end