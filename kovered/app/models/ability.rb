class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      user.build_role if user.role.nil?
      alias_action :show, :update, :destroy, :to => :sud

      if user.role.admin?
        can :access, :rails_admin       # only allow admin users to access Rails Admin
        can :dashboard
        can :manage, :all

      elsif user.role.executive?
        cannot :manage, :all
        can :sud, Executive, :user_id => user.id

      elsif user.role.artist?
        cannot :manage, :all
        can :sud, Artist, :user_id => user.id
        # cannot :index, Artist
        # can [:show, :edit, :update], User do |current_user|
        #   user.id == current_user.id || user.role.admin?
        # end

      elsif user.role.fan?
        cannot :manage, :all
        can :sud, Fan, :user_id => user.id

      else
        cannot :manage, :all
        can [:show, :create], [Fan, Artist, Executive ]

      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
