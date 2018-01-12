
  module VotesHelper

    def product_vote(user_vote, product)
      if !@user_vote
        link_1 = link_to fa_icon('chevron-up 2x'),
          product_votes_path(@product, { is_up: true }),
          method: :post
        link_2 = link_to fa_icon('chevron-down 2x'),
          product_votes_path(@product, { is_up: false }),
          method: :post
      elsif @user_vote.is_up?
        link_1 = link_to fa_icon('chevron-circle-up 2x'),
          vote_path(@user_vote),
          method: :delete
        link_2 = link_to fa_icon('chevron-down 2x'),
          vote_path(@user_vote, { is_up: false}),
          method: :patch
      else
        link_1 = link_to fa_icon('chevron-up 2x'),
          vote_path(@user_vote, { is_up: true }),
          method: :patch
        link_2 = link_to fa_icon('chevron-circle-down 2x'),
          vote_path(@user_vote),
          method: :delete
      end
      "#{link_1} (#{product.votes_result}) #{link_2}"
       # votes_result is a method defined in product.rb
    end

  end
