class StoragesController < ApplicationController
  before_action :set_storage, only: %i[ show edit update destroy ]

  # GET /storages or /storages.json
  def index
    @storages = Storage.all
  end

  # GET /storages/1 or /storages/1.json
  def show
  end

  # GET /storages/new
  def new
    @storage = Storage.new
  end


  # GET /storages/1/edit
  def edit
  end

  # POST /storages or /storages.json
  def create
    @last_id = Storage.all.last.id
    @storage = Storage.new(storage_params)
    @storage.id = @last_id + 1
    respond_to do |format|
      if @storage.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_form', partial: 'storages/new_form', locals: {storage: Storage.new}),
            turbo_stream.update('svg', partial: 'storages/storage', locals: {storages: Storage.all})
          ]
        end
        format.html { redirect_to root_path, notice: "Storage was successfully created." }
        format.json { render :index, status: :created, location: @storages }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_form', partial: 'storages/new_form', locals: {storage: @storage})
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /storages/1 or /storages/1.json
  def update
    respond_to do |format|
      if @storage.update(storage_params)
          format.turbo_stream do
            render turbo_stream: [
            turbo_stream.replace('svg', partial: "storages/storage", locals: {storages: Storage.all}),
            turbo_stream.update('modal',partial: 'storages/notice')
            ]
          end
        # format.html { redirect_to storage_url(@storage), notice: "Storage was successfully updated." }
        # format.json { rendesr :show, status: :ok, location: @storage }
      else
        format.turbo_stream do
          render turbo_stream: [
          turbo_stream.update('modal', partial: 'storages/error')
          ]
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /storages/1 or /storages/1.json
  def destroy
    @storage.destroy
    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: [
          turbo_stream.remove(@storage),
          turbo_stream.update('svg', partial: "storages/storage", locals: {storages: Storage.all})
        ]
      end
      format.html { redirect_to storages_url, notice: "Storage was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_storage
      @storage = Storage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def storage_params
      params.require(:storage).permit( :book, :available, :booked, :x, :y, :width, :height)
    end
end
