
  module VotesHelper

    def product_vote(user_vote, product)
      if !@user_vote
        link_1 = link_to fa_icon('chevron-up 2x'),
          product_votes_path(@product, { is_up: true }),
          method: :post, class: "text-success"
        link_2 = link_to fa_icon('chevron-down 2x'),
          product_votes_path(@product, { is_up: false }),
          method: :post, class: "text-success"
      elsif @user_vote.is_up?
        link_1 = link_to fa_icon('chevron-circle-up 2x'),
          vote_path(@user_vote),
          method: :delete, class: "text-success"
        link_2 = link_to fa_icon('chevron-down 2x'),
          vote_path(@user_vote, { is_up: false}),
          method: :patch, class: "text-success"
      else
        link_1 = link_to fa_icon('chevron-up 2x'),
          vote_path(@user_vote, { is_up: true }),
          method: :patch, class: "text-success"
        link_2 = link_to fa_icon('chevron-circle-down 2x'),
          vote_path(@user_vote),
          method: :delete, class: "text-success"
      end

      "#{link_1} <span class='badge badge-success'>#{product.votes_result}</span> #{link_2}"
       # votes_result is a method defined in product.rb
    end

  end
