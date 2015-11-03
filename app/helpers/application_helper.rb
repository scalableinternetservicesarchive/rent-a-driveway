module ApplicationHelper

def header(text)
	content_for(:header) {text.to_s }
end
def sortable(column, title = nil, params)
      title ||= column.titleize
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to title, params.merge({:sort => column, :direction => direction }), { :class => css_class }
    end

    
private
def sort_column
      Listing.column_names.include?(params[:sort]) ? params[:sort] : "price"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
