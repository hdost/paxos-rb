module Paxos
	class Acceptor

		def initialize
			@promised_id 		= nil
			@accepted_value = nil
			@accepted_id 		= nil
			@previous_id 		= nil
		end

		def receive_prepare(proposal_id)
			if (proposal_id <=> @promised_id) == 0
				return proposal_id, @previous_id, @accepted_value
			end

			if @promised_id.nil? || proposal_id > @promised_id
				@previous_id = @promised_id
				@promised_id = proposal_id

				return proposal_id, @previous_id, @accepted_value
			end
		end

		def receive_accept_request(proposal_id, value)
			if @promised_id.nil? || proposal_id >= @promised_id
				@accepted_value = value
				@promised_id = proposal_id
				return proposal_id, @accepted_value
			end
		end
	end
end
