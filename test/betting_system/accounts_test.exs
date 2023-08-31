defmodule BettingSystem.AccountsTest do
  use BettingSystem.DataCase

  alias BettingSystem.Accounts

  describe "users" do
    alias BettingSystem.Accounts.AccountManagement

    import BettingSystem.AccountsFixtures

    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, msisdn: nil}

    test "list_users/0 returns all users" do
      account_management = account_management_fixture()
      assert Accounts.list_users() == [account_management]
    end

    test "get_account_management!/1 returns the account_management with given id" do
      account_management = account_management_fixture()
      assert Accounts.get_account_management!(account_management.id) == account_management
    end

    test "create_account_management/1 with valid data creates a account_management" do
      valid_attrs = %{email: "some email", first_name: "some first_name", last_name: "some last_name", msisdn: "some msisdn"}

      assert {:ok, %AccountManagement{} = account_management} = Accounts.create_account_management(valid_attrs)
      assert account_management.email == "some email"
      assert account_management.first_name == "some first_name"
      assert account_management.last_name == "some last_name"
      assert account_management.msisdn == "some msisdn"
    end

    test "create_account_management/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account_management(@invalid_attrs)
    end

    test "update_account_management/2 with valid data updates the account_management" do
      account_management = account_management_fixture()
      update_attrs = %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", msisdn: "some updated msisdn"}

      assert {:ok, %AccountManagement{} = account_management} = Accounts.update_account_management(account_management, update_attrs)
      assert account_management.email == "some updated email"
      assert account_management.first_name == "some updated first_name"
      assert account_management.last_name == "some updated last_name"
      assert account_management.msisdn == "some updated msisdn"
    end

    test "update_account_management/2 with invalid data returns error changeset" do
      account_management = account_management_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account_management(account_management, @invalid_attrs)
      assert account_management == Accounts.get_account_management!(account_management.id)
    end

    test "delete_account_management/1 deletes the account_management" do
      account_management = account_management_fixture()
      assert {:ok, %AccountManagement{}} = Accounts.delete_account_management(account_management)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account_management!(account_management.id) end
    end

    test "change_account_management/1 returns a account_management changeset" do
      account_management = account_management_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account_management(account_management)
    end
  end
end
