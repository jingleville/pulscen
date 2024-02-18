class PagesController < ApplicationController
  before_action :set_page, only: %w[ show edit destroy new create update]
  def index
    @pages = Page.hash_tree
    @root_pages = Page.roots
  end

  def show
    @children = @page.children
    @body = @page.body.sub(/(?<foo>(\**\*))/, '<b>\\k<foo></b>')
  
# "hello".sub(/[aeiou]/, '*')                  #=> "h*llo"
# "hello".sub(/([aeiou])/, '<\1>')             #=> "h<e>llo"
# "hello".sub(/./) {|s| s.ord.to_s + ' ' }     #=> "104 ello"
# "hello".sub(/(?<foo>[aeiou])/, '*\k<foo>*')  #=> "h*e*llo"
# 'Is SHELL your preferred shell?'.sub(/[[:upper:]]{2,}/, ENV)
 #=> "Is /bin/bash your preferred shell?"

  end

  # GET /pages/new
  def new
    @parent = @page
    @page = @parent.children.new
  end

  def new_root
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages or /pages.json
  def create
    @new_page = @page.children.build(page_params)
    @new_page.path = "#{@page.path}/#{page_params[:name]}"
    respond_to do |format|
      if @new_page.save!
        format.html { redirect_to @new_page.path, notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @new_page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @new_page.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_root
    @page = Page.new(page_params, path: "/#{page_params[:name]}")

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page.path, notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page.path, notice: "Page was successfully updated." }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy!

    respond_to do |format|
      format.html { redirect_to pages_url, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find_sole_by(["path = ?", '/' + params[:pages]])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:name, :title, :body)
    end
end
