module PlayersHelper

	# def check_toggle(plr)

	# 	return <%= link_to "Toggle", toggle_player_path(plr.id), :class => 'btn btn-success btn-small'  %>

	# 	# if session[:round_id] != nil
	# 	# 	return link_to "Delete Round", round_path(session[:round_id]), :method => :delete,  :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Are you sure?')) }, :class => 'btn btn-danger btn'
	# 	# else
	# 	# 	return link_to "Create Round", new_round_path, :class => 'btn btn-success btn-large'
	# 	# end	

	# end


	def check_toggle(plr)

		if plr.is_playing == true
			return link_to "Yes", toggle_player_path(plr.id), :class => 'btn btn-success btn-small togbut' 
		else
			return link_to "No", toggle_player_path(plr.id), :class => 'btn btn-danger btn-small togbut'
		end
	end


	def round_estimate(plr, rnd)

		total = LineItem.where(:player_id => plr.id, :round_id => rnd.id).sum(&:amount)

		return total
	end

	def get_call_val(plr, rnd)

		total_level = LineItem.where(:player_id => plr.id, :round_id => rnd.id, :level => rnd.level).sum(&:amount)

		return rnd.call_value - total_level 
	end


end
