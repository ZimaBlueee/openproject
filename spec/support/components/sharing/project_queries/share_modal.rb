# -- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2010-2024 the OpenProject GmbH
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
# ++

require_relative "../../sharing/share_modal"

module Components
  module Sharing
    module ProjectQueries
      class ShareModal < Components::Sharing::ShareModal
        # rubocop:disable Lint/MissingSuper
        def initialize(project_query)
          @entity = project_query
          @title = I18n.t(:label_share_project_list)
        end
        # rubocop:enable Lint/MissingSuper

        def expect_sharing_forbidden_banner
          expect(page).to have_text("You don't have permissions to share Custom query.")
        end

        def close
          click_on(class: "Overlay-closeButton")
        end
      end
    end
  end
end
