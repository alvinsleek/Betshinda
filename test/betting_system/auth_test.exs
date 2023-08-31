defmodule BettingSystem.AuthTest do
  use BettingSystem.DataCase

  alias BettingSystem.Auth

  describe "users" do
    alias BettingSystem.Auth.UserRegistration

    import BettingSystem.AuthFixtures

    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, msisdn: nil}

    test "list_users/0 returns all users" do
      user_registration = user_registration_fixture()
      assert Auth.list_users() == [user_registration]
    end

    test "get_user_registration!/1 returns the user_registration with given id" do
      user_registration = user_registration_fixture()
      assert Auth.get_user_registration!(user_registration.id) == user_registration
    end

    test "create_user_registration/1 with valid data creates a user_registration" do
      valid_attrs = %{email: "some email", first_name: "some first_name", last_name: "some last_name", msisdn: "some msisdn"}

      assert {:ok, %UserRegistration{} = user_registration} = Auth.create_user_registration(valid_attrs)
      assert user_registration.email == "some email"
      assert user_registration.first_name == "some first_name"
      assert user_registration.last_name == "some last_name"
      assert user_registration.msisdn == "some msisdn"
    end

    test "create_user_registration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user_registration(@invalid_attrs)
    end

    test "update_user_registration/2 with valid data updates the user_registration" do
      user_registration = user_registration_fixture()
      update_attrs = %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", msisdn: "some updated msisdn"}

      assert {:ok, %UserRegistration{} = user_registration} = Auth.update_user_registration(user_registration, update_attrs)
      assert user_registration.email == "some updated email"
      assert user_registration.first_name == "some updated first_name"
      assert user_registration.last_name == "some updated last_name"
      assert user_registration.msisdn == "some updated msisdn"
    end

    test "update_user_registration/2 with invalid data returns error changeset" do
      user_registration = user_registration_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user_registration(user_registration, @invalid_attrs)
      assert user_registration == Auth.get_user_registration!(user_registration.id)
    end

    test "delete_user_registration/1 deletes the user_registration" do
      user_registration = user_registration_fixture()
      assert {:ok, %UserRegistration{}} = Auth.delete_user_registration(user_registration)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user_registration!(user_registration.id) end
    end

    test "change_user_registration/1 returns a user_registration changeset" do
      user_registration = user_registration_fixture()
      assert %Ecto.Changeset{} = Auth.change_user_registration(user_registration)
    end
  end

  describe "user_login_sessions" do
    alias BettingSystem.Auth.UserLoginSession

    import BettingSystem.AuthFixtures

    @invalid_attrs %{}

    test "list_user_login_sessions/0 returns all user_login_sessions" do
      user_login_session = user_login_session_fixture()
      assert Auth.list_user_login_sessions() == [user_login_session]
    end

    test "get_user_login_session!/1 returns the user_login_session with given id" do
      user_login_session = user_login_session_fixture()
      assert Auth.get_user_login_session!(user_login_session.id) == user_login_session
    end

    test "create_user_login_session/1 with valid data creates a user_login_session" do
      valid_attrs = %{}

      assert {:ok, %UserLoginSession{} = user_login_session} = Auth.create_user_login_session(valid_attrs)
    end

    test "create_user_login_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user_login_session(@invalid_attrs)
    end

    test "update_user_login_session/2 with valid data updates the user_login_session" do
      user_login_session = user_login_session_fixture()
      update_attrs = %{}

      assert {:ok, %UserLoginSession{} = user_login_session} = Auth.update_user_login_session(user_login_session, update_attrs)
    end

    test "update_user_login_session/2 with invalid data returns error changeset" do
      user_login_session = user_login_session_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user_login_session(user_login_session, @invalid_attrs)
      assert user_login_session == Auth.get_user_login_session!(user_login_session.id)
    end

    test "delete_user_login_session/1 deletes the user_login_session" do
      user_login_session = user_login_session_fixture()
      assert {:ok, %UserLoginSession{}} = Auth.delete_user_login_session(user_login_session)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user_login_session!(user_login_session.id) end
    end

    test "change_user_login_session/1 returns a user_login_session changeset" do
      user_login_session = user_login_session_fixture()
      assert %Ecto.Changeset{} = Auth.change_user_login_session(user_login_session)
    end
  end
end
