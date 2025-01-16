defmodule Api.Repo.Migrations.CreateTableUsers do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, null: false
      add :status, :string, default: "active"
      add :inactivated_at, :date

      timestamps()
      soft_delete_columns()
    end

    create unique_index(:users, [:email])
  end
end
