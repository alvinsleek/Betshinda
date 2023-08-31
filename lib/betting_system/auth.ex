defmodule BettingSystem.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias BettingSystem.Repo

  alias BettingSystem.Auth.UserRegistration

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%UserRegistration{}, ...]

  """
  def list_users do
    Repo.all(UserRegistration)
  end

  @doc """
  Gets a single user_registration.

  Raises `Ecto.NoResultsError` if the User registration does not exist.

  ## Examples

      iex> get_user_registration!(123)
      %UserRegistration{}

      iex> get_user_registration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_registration!(id), do: Repo.get!(UserRegistration, id)

  @doc """
  Creates a user_registration.

  ## Examples

      iex> create_user_registration(%{field: value})
      {:ok, %UserRegistration{}}

      iex> create_user_registration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_registration(attrs \\ %{}) do
    %UserRegistration{}
    |> UserRegistration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_registration.

  ## Examples

      iex> update_user_registration(user_registration, %{field: new_value})
      {:ok, %UserRegistration{}}

      iex> update_user_registration(user_registration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_registration(%UserRegistration{} = user_registration, attrs) do
    user_registration
    |> UserRegistration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_registration.

  ## Examples

      iex> delete_user_registration(user_registration)
      {:ok, %UserRegistration{}}

      iex> delete_user_registration(user_registration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_registration(%UserRegistration{} = user_registration) do
    Repo.delete(user_registration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_registration changes.

  ## Examples

      iex> change_user_registration(user_registration)
      %Ecto.Changeset{data: %UserRegistration{}}

  """
  def change_user_registration(%UserRegistration{} = user_registration, attrs \\ %{}) do
    UserRegistration.changeset(user_registration, attrs)
  end

  alias BettingSystem.Auth.UserLoginSession

  @doc """
  Returns the list of user_login_sessions.

  ## Examples

      iex> list_user_login_sessions()
      [%UserLoginSession{}, ...]

  """
  def list_user_login_sessions do
    Repo.all(UserLoginSession)
  end

  @doc """
  Gets a single user_login_session.

  Raises `Ecto.NoResultsError` if the User login session does not exist.

  ## Examples

      iex> get_user_login_session!(123)
      %UserLoginSession{}

      iex> get_user_login_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_login_session!(id), do: Repo.get!(UserLoginSession, id)

  @doc """
  Creates a user_login_session.

  ## Examples

      iex> create_user_login_session(%{field: value})
      {:ok, %UserLoginSession{}}

      iex> create_user_login_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_login_session(attrs \\ %{}) do
    %UserLoginSession{}
    |> UserLoginSession.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_login_session.

  ## Examples

      iex> update_user_login_session(user_login_session, %{field: new_value})
      {:ok, %UserLoginSession{}}

      iex> update_user_login_session(user_login_session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_login_session(%UserLoginSession{} = user_login_session, attrs) do
    user_login_session
    |> UserLoginSession.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_login_session.

  ## Examples

      iex> delete_user_login_session(user_login_session)
      {:ok, %UserLoginSession{}}

      iex> delete_user_login_session(user_login_session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_login_session(%UserLoginSession{} = user_login_session) do
    Repo.delete(user_login_session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_login_session changes.

  ## Examples

      iex> change_user_login_session(user_login_session)
      %Ecto.Changeset{data: %UserLoginSession{}}

  """
  def change_user_login_session(%UserLoginSession{} = user_login_session, attrs \\ %{}) do
    UserLoginSession.changeset(user_login_session, attrs)
  end
end
