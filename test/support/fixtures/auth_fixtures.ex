defmodule BettingSystem.AuthFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BettingSystem.Auth` context.
  """

  @doc """
  Generate a user_registration.
  """
  def user_registration_fixture(attrs \\ %{}) do
    {:ok, user_registration} =
      attrs
      |> Enum.into(%{
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        msisdn: "some msisdn"
      })
      |> BettingSystem.Auth.create_user_registration()

    user_registration
  end

  @doc """
  Generate a user_login_session.
  """
  def user_login_session_fixture(attrs \\ %{}) do
    {:ok, user_login_session} =
      attrs
      |> Enum.into(%{

      })
      |> BettingSystem.Auth.create_user_login_session()

    user_login_session
  end
end
