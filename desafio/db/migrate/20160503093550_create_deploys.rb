class CreateDeploys < ActiveRecord::Migration
  def change
    create_table :deploys do |t|
      t.string :componente
      t.string :versao
      t.string :responsavel
      t.string :status

      t.timestamps null: false
    end
  end
end
