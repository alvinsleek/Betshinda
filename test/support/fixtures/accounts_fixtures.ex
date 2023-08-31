defmodule BettingSystem.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BettingSystem.Accounts` context.
  """

  @doc """
  Generate a account_management.
  """
  def account_management_fixture(attrs \\ %{}) do
    {:ok, account_management} =
      attrs
      |> Enum.into(%{
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        msisdn: "some msisdn"
      })
      |> BettingSystem.Accounts.create_account_management()

    account_management
  end
end
