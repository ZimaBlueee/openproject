# frozen_string_literal: true

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2024 the OpenProject GmbH
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

class Storages::Admin::Storages::ProjectStoragesController < ApplicationController
  include OpTurbo::ComponentStream
  include OpTurbo::DialogStreamHelper

  layout "admin"

  model_object Storages::Storage

  before_action :require_admin
  before_action :find_model_object
  before_action :load_project_storage, only: %i(destroy destroy_confirmation_dialog)

  menu_item :external_file_storages

  def index
    @project_query = ProjectQuery.new(
      name: "project-storage-mappings-#{@storage.id}"
    ) do |query|
      query.where(:storages, "=", [@storage.id])
      query.select(:name)
      query.order("lft" => "asc")
    end
  end

  def new; end
  def create; end

  def destroy_confirmation_dialog
    respond_with_dialog Storages::ProjectStorages::DestroyConfirmationDialogComponent.new(
      storage: @storage,
      project_storage: @project_storage
    )
  end

  def destroy
    @project_storage.destroy
    redirect_to admin_settings_storage_project_storages_path(@storage)
  end

  private

  def load_project_storage
    @project_storage = Storages::ProjectStorage.find(params[:id])
  end

  def find_model_object(object_id = :storage_id)
    super
    @storage = @object
  end
end
