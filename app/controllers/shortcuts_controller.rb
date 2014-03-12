class ShortcutsController < ApplicationController
  before_action :set_shortcut, only: [:show, :edit, :update, :destroy]

  # GET /shortcuts
  # GET /shortcuts.json
  def index
    @shortcuts = Shortcut.all
  end

  # GET /shortcuts/1
  # GET /shortcuts/1.json
  def show
  end

  # GET /shortcuts/new
  def new
    @shortcut = Shortcut.new
    @shortcut.steps.build
    @shortcut.tags.build
  end

  # GET /shortcuts/1/edit
  def edit
    puts "#{params[:id]}"
    @shortcut = Shortcut.find(params[:id])
  end

  # POST /shortcuts
  # POST /shortcuts.json
  def create
    puts params
    @shortcut = Shortcut.new(shortcut_params)
    respond_to do |format|
      if @shortcut.save
        format.html { redirect_to @shortcut, notice: 'Shortcut was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shortcut }
      else
        format.html { render action: 'new' }
        format.json { render json: @shortcut.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shortcuts/1
  # PATCH/PUT /shortcuts/1.json
  def update
    respond_to do |format|
      if @shortcut.update(shortcut_params)
        format.html { redirect_to @shortcut, notice: 'Shortcut was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shortcut.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shortcuts/1
  # DELETE /shortcuts/1.json
  def destroy
    @shortcut.destroy
    respond_to do |format|
      format.html { redirect_to shortcuts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shortcut
      @shortcut = Shortcut.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shortcut_params
      params.require(:shortcut).permit(:title, :description,
        steps_attributes: [ :id, :step_number, :text, :image_url, :_destroy ],
        tags_attributes: [ :id, :name, :_destroy ])
    end

    def step_params
      params.require(:step).permit(:shortcut_id, :step_number, :text, :image_url)
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
end
