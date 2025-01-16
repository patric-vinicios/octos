defmodule Api.Repo.Migrations.CreateCamerasTable do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:cameras) do
      add :brand_name, :string
      add :status, :string, default: "active"

      add :user_id, references(:users, type: :binary_id)

      timestamps()
      soft_delete_columns()
    end

    create index(:cameras, [:brand_name])

    execute("CREATE EXTENSION IF NOT EXISTS pg_trgm", "DROP EXTENSION IF EXISTS pg_trgm")

    execute(
      "CREATE INDEX cameras_brand_name_trgm_idx ON cameras USING gin (brand_name gin_trgm_ops);"
    )
  end
end
