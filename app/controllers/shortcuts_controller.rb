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
    @step = Step.new
    @tag = Tag.new
    @shortcut_tag = ShortcutTag.new
  end

  # GET /shortcuts/1/edit
  def edit
    puts "#{params[:id]}"
    @shortcut = Shortcut.find(params[:id])
    @steps_array = @shortcut.steps
    @shortcut_tag = ShortcutTag.where(shortcut_id: params[:id])
    @tags_array = []
    @shortcut_tag.each do |value|
      @tags_array << Tag.find_by(id: value.tag_id)
    end
  end

  # POST /shortcuts
  # POST /shortcuts.json
  def create
    @shortcut = Shortcut.new(shortcut_params)
    @shortcut.save
    @steps_array = []
    @step = Step.new(step_params)
    @step.shortcut_id = @shortcut.id
    @step.save
    @tag = Tag.new(tag_params)
    @tag.save

    @shortcut_tag = ShortcutTag.new(shortcut_id: @shortcut.id, tag_id: @tag.id)
    @shortcut_tag.save

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
      @step = Step.find_by(id: params[:step][:id])
      @tag = Tag.find_by(id: params[:tag][:id])
      if @shortcut.update(shortcut_params) && @step.update(step_params) && @tag.update(tag_params)
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
      params.require(:shortcut).permit(:title, :description)
    end

    def step_params
      params.require(:step).permit(:shortcut_id, :step_number, :text, :image_url)
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
end
