defmodule BettingSystem.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias BettingSystem.Repo

  alias BettingSystem.Accounts.AccountManagement

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%AccountManagement{}, ...]

  """
  def list_users do
    Repo.all(AccountManagement)
  end

  @doc """
  Gets a single account_management.

  Raises `Ecto.NoResultsError` if the Account management does not exist.

  ## Examples

      iex> get_account_management!(123)
      %AccountManagement{}

      iex> get_account_management!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account_management!(id), do: Repo.get!(AccountManagement, id)

  @doc """
  Creates a account_management.

  ## Examples

      iex> create_account_management(%{field: value})
      {:ok, %AccountManagement{}}

      iex> create_account_management(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account_management(attrs \\ %{}) do
    %AccountManagement{}
    |> AccountManagement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account_management.

  ## Examples

      iex> update_account_management(account_management, %{field: new_value})
      {:ok, %AccountManagement{}}

      iex> update_account_management(account_management, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account_management(%AccountManagement{} = account_management, attrs) do
    account_management
    |> AccountManagement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account_management.

  ## Examples

      iex> delete_account_management(account_management)
      {:ok, %AccountManagement{}}

      iex> delete_account_management(account_management)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account_management(%AccountManagement{} = account_management) do
    Repo.delete(account_management)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account_management changes.

  ## Examples

      iex> change_account_management(account_management)
      %Ecto.Changeset{data: %AccountManagement{}}

  """
  def change_account_management(%AccountManagement{} = account_management, attrs \\ %{}) do
    AccountManagement.changeset(account_management, attrs)
  end
end
