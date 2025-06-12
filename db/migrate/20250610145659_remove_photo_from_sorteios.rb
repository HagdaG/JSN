# db/migrate/YYYYMMDDHHMMSS_remove_photo_from_sorteios.rb
class RemovePhotoFromSorteios < ActiveRecord::Migration[8.0] # A versão do Rails pode ser diferente
  def change
    remove_column :sorteios, :photo, :string # <--- DEVE ESTAR ASSIM
  end
end
