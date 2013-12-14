class RentersController < ApplicationController
  
  before_action :signed_in_user, only: [:index, :new, :create, :edit, :destroy, :update]
  before_action :admin_user, only: [:index, :new, :create, :edit, :destroy, :update]
  
  def new
    @renter = Renter.new
  end


  def index
    @renters = Renter.all.order('ap_num ASC')
  end
  
  def show
    @renter = Renter.find(params[:id])
  end
  
  def create
    @renter = Renter.new(renter_params)
    if @renter.save
      flash[:success] = "Yeni kiracı başarıyla eklendi."
      redirect_to renters_path
    else
      render 'new'
    end  
  end
  
  def edit
    @renter = Renter.find(params[:id])
  end
  
  def update
    @renter = Renter.find(params[:id])
    if @renter.update_attributes(renter_params)
      flash[:success] = "Kiracı bilgileri güncellendi."
      redirect_to renters_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @kiraci = Renter.find(params[:id])
    Aidat.destroy_all(:daire => ( @kiraci.ap_num ) )
    @kiraci.destroy
    flash[:success] = "Kiracı başarıyla silindi."
    redirect_to renters_path
  end
  
  private
    def renter_params
      params.require(:renter).permit(:ap_num, :name, :email, :phone, :meslek, :medeni_durum, :birey_sayisi, :cocuk_sayisi, :memleket, :ev_sahibi, :ev_sahibi_telefon, :kira_miktari)
    end
    
end
