module ApplicationHelper

  def list_of_tags(creation)
    creation.tags.to_a
        .map { |tag| tag.name }
        .map(&:inspect)
        .map { |tag| tag[1...-1] }
        .join(', ')
  end

  def stylesheet_link_tag_ng
    link = stylesheet_link_tag('light-bootstrap.min')[0..-3]
    link << %&ng-disabled = "style != 'light'" /> &
    link << stylesheet_link_tag('dark-bootstrap.min')[0..-3]
    link << %&ng-disabled = "style != 'dark'" /> &
  end

end
