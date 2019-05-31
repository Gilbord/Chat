defmodule Chat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :user_name, :string
      add :message, :text

      timestamps()
    end

  end
end
