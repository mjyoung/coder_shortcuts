class ShortcutsController < ApplicationController
  before_action :set_shortcut, only: [:show, :edit, :update, :destroy]
  # before_filter :authenticate_user!

  # GET /shortcuts
  # GET /shortcuts.json
  def index
    @shortcuts = Shortcut.search(params[:search]).paginate(:per_page => 5, :page => params[:page])
  end

  # GET /shortcuts/1
  # GET /shortcuts/1.json
  def show
    @steps = @shortcut.steps.order(step_number: :asc)
    @tags = @shortcut.tags.order(name: :asc)
    @user = @shortcut.user.username
    @last_modified = @shortcut.updated_at.to_date
  end

  # GET /shortcuts/new
  def new
    @shortcut = Shortcut.new
    @shortcut.steps.build
    @shortcut.tags.build
    @tags_string = ""
  end

  # GET /shortcuts/1/edit
  def edit
    puts "#{params[:id]}"
    @shortcut = Shortcut.find(params[:id])

    tags_array = []
    @shortcut.tags.each { |tag| tags_array << tag.name }
    @tags_string = tags_array.join(", ")
  end

  # POST /shortcuts
  # POST /shortcuts.json
  def create
    puts params.to_json
    puts "#{current_user} #{current_user.id} #{current_user.email} #{current_user.username}"
    @shortcut = Shortcut.new(shortcut_params)
    @shortcut.user = current_user

    tags_string_to_tags

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
    puts params.to_json

    tags_string_to_tags

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

    def tags_string_to_tags
      tags_string = params['tags_string']
      tags_array = tags_string.downcase.split(",").map(&:strip)

      tags = []
      tags_array.each do |tag|
        tags << Tag.find_or_create_by(name: tag)
      end
      @shortcut.tags = tags
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shortcut_params
      params.require(:shortcut).permit( :id, :title, :description,
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
