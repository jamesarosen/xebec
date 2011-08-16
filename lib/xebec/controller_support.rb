require 'xebec/has_nav_bars'

module Xebec

  # Include this module in Rails controllers if you want to declare
  # navigation bars in your controllers instead of or in addition to
  # in your views.
  module ControllerSupport

    def self.included(base)
      base.extend Xebec::ControllerSupport::ClassMethods
      base.send :include, Xebec::ControllerSupport::InstanceMethods
      base.send :include, Xebec::HasNavBars
    end

    module ClassMethods

      # Declare and populate a navigation bar. This method
      # is a shorthand for creating a +before_filter+ that looks
      # up and populates a navigation bar.
      #
      # @param [String, Symbol] name the name of the navigation bar;
      #                         optional
      #
      # @param [Hash] options the options for the +before_filter+;
      #                       optional.
      #
      # @yield [Xebec::NavBar] nav_bar the navigation bar -- NB: does
      #                        NOT yield at call-time, but at action
      #                        run-time, as a before filter. The block
      #                        is evaluated in the scope of the controller
      #                        instance.
      #
      # @return [nil]
      #
      # @example
      #   nav_bar :tabs, :only => [:index, :sent, :received, :new] do |nb|
      #     nb.nav_item :received, received_messages_path(current_user)
      #     nb.nav_item :sent,     sent_messages_path(current_user)
      #     nb.nav_item :new,      new_message_path
      #   end
      def nav_bar(name = Xebec::NavBar::DEFAULT_NAME, options = {}, &block)
        append_before_filter options do |controller|
          controller.nav_bar name, &block
        end
        nil
      end

    end

    module InstanceMethods

      # Declare and populate a navigation bar.
      #
      # @param [String, Symbol] name the name of the navigation bar
      #
      # @yield [Xebec::NavBar] nav_bar the navigation bar. The block
      #                        is evaluated in the scope of the
      #                        controller instance.
      #
      # @return [Xebec::NavBar]
      #
      # @example
      #   nav_bar :tabs do |nb|
      #     nb.nav_item :overview, @project
      #     nb.nav_item :budget,   budget_project_path(@project)
      #     nb.nav_item :edit,     edit_project_path(@project)
      #   end
      def nav_bar(name = Xebec::NavBar::DEFAULT_NAME, &block)
        look_up_nav_bar_and_eval name, &block
      end

    end

  end

end
