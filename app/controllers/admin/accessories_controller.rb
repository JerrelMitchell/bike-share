class Admin::AccessoriesController < Admin::BaseController
  def index
    @accessories = Accessory.paginate(page: params[:page], per_page: 12).order('id DESC' )
  end

  def show
    @accessory = Accessory.find(params[:id])
  end

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.create(accessory_params)
    if @accessory.save
      redirect_to admin_bike_shop_path
    else
      flash[:notice] = "Accessory #{@accessory.title} already exists. Please fill in fields with valid information."
      render :new
    end
  end

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def update
    @accessory =  Accessory.find(params[:id])

    @accessory.update(accessory_params)
    redirect_to admin_bike_shop_path
  end


  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :thumbnail, :price, :role)
  end
end
