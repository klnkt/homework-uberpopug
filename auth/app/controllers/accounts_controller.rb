class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_account!, only: [:index]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/current.json
  def current
    respond_to do |format|
      format.json { render json: current_account }
    end
  end

  # GET /accounts/:id/edit
  def edit; end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      new_role = @account.role != account_params[:role] ? account_params[:role] : nil

      if @account.update(account_params)
        send_event(:updated)
        send_event(:role_changed) if new_role

        format.html { redirect_to root_path, notice: 'Account was successfully updated.' }
        format.json { render :index, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  #
  # in DELETE action, CUD event
  def destroy
    @account.destroy

    send_event(:deleted)

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def current_account
    if doorkeeper_token
      Account.find(doorkeeper_token.resource_owner_id)
    else
      super
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:full_name, :role)
  end

  def send_event(action)
    case action
    when 'updated'
      event = {
        event_name: 'AccountUpdated',
        data: update_payload
      }
    when 'deleted'
      event = {
      event_name: 'AccountDeleted',
      data: delete_payload
    }
    when 'role_changed'
      event = {
            event_name: 'AccountRoleChanged',
            data: role_change_payload
          }
    end
    Producer.call(event.to_json, topic: 'accounts-stream')
  end

  def update_payload
    {
      public_id: @account.public_id,
      email: @account.email,
      full_name: @account.full_name
    }
  end

  def delete_payload
    { public_id: @account.public_id }
  end

  def role_change_payload
    { public_id: @account.public_id, role: @account.role }
  end
end
