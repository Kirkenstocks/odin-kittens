class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    # API to get all kitten data
    respond_to do |f|
      f.html
      f.json { render json: @kittens }
    end
  end


  def show
    @kitten = Kitten.find(params[:id])

    # API to get the kitten's data
    respond_to do |f|
      f.html
      f.json { render json: @kitten }
    end
  end


  def new
    @kitten = Kitten.new
  end


  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash.notice = "Your new kitten joined the litter!"
      redirect_to @kitten
    else
      flash.alert = "Unable to add kitten. Fill out all fields and try again."
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @kitten = Kitten.find(params[:id])
  end


  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash.notice = "Your kitten rejoined the litter!"
      redirect_to @kitten
    else
      flash.alert = "Unable to change kitten. Fill out all fields and try again."
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash.notice = "Kitten removed from the litter. You monster!"
    redirect_to root_path, status: :see_other
  end


  private
  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end