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

require "rails_helper"
require "support/shared/project_life_cycle_helpers"

RSpec.describe Projects::Stage do
  it_behaves_like "a ProjectLifeCycle event"

  describe "validations" do
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }

    it "is valid when `start_date` and `end_date` are present" do
      valid_stage = build(:project_stage)
      expect(valid_stage).to be_valid
    end

    it "adds an error when `date` is set" do
      stage_with_date = build(:project_stage, date: Time.zone.today)

      expect(stage_with_date).not_to be_valid
      expect(stage_with_date.errors[:base]).to include("Cannot assign `date` to a Stage")
    end
  end
end
