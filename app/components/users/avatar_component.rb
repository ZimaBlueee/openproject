#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

module Users
  class AvatarComponent < ApplicationComponent
    include ApplicationHelper
    include AvatarHelper
    include OpPrimer::ComponentHelpers

    def initialize(user:, show_name: true, link: true, size: "default", classes: "", title: nil, name_classes: "",
                   hover_card: false)
      super

      @user = user
      @show_name = show_name
      @link = link
      @size = size
      @title = title
      @hover_card = hover_card
      @classes = classes
      # The hover card will be triggered by hovering over the avatar (if enabled)
      @avatar_classes = hover_card ? "op-hover-card--preview-trigger" : nil
      @name_classes = name_classes
    end

    def render?
      @user.present?
    end

    def call
      options = {
        size: @size,
        link: @link,
        hide_name: !@show_name,
        title: @title,
        class: @classes,
        name_classes: @name_classes,
        avatar_classes: @avatar_classes
      }

      if @hover_card
        options[:hover_card_close_delay] = 600
        options[:hover_card_alignment] = "top"
      end

      helpers.avatar(
        @user,
        **options
      )
    end
  end
end
