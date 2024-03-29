class SettingsController < ApplicationController
  skip_before_action  :verify_authenticity_token

  # GET /settings
  # GET /settings.json
  def index
    @settings = Setting.all_cached
    respond_to do |format|
      format.html{}
      format.json { render json: @settings }
    end
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render json: :@setting, status: :created }
      else
        format.html { render :new }
        format.json { render json: @setting.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      @setting = Setting.find_cached(params[:id])
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { render json: :@setting, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting = Setting.find_cached(params[:id])
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: 'Setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:data_type, :key, :value)
    end
end
