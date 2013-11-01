module ApplicationHelper
	def check_session_btn
		if session[:round_id] != nil
			return link_to "Delete Round", round_path(session[:round_id]), :method => :delete,  :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Are you sure?')) }, :class => 'btn btn-danger btn'
		else
			return link_to "Create Round", new_round_path, :class => 'btn btn-success btn-large'
		end	

	end

	def current_round

		Round.find(session[:round_id])

	end
end
