defmodule BettingSystemWeb.UserRegistrationLiveTest do
  use BettingSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import BettingSystem.AuthFixtures

  @create_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", msisdn: "some msisdn"}
  @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", msisdn: "some updated msisdn"}
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil, msisdn: nil}

  defp create_user_registration(_) do
    user_registration = user_registration_fixture()
    %{user_registration: user_registration}
  end

  describe "Index" do
    setup [:create_user_registration]

    test "lists all users", %{conn: conn, user_registration: user_registration} do
      {:ok, _index_live, html} = live(conn, ~p"/users")

      assert html =~ "Listing Users"
      assert html =~ user_registration.email
    end

    test "saves new user_registration", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("a", "New User registration") |> render_click() =~
               "New User registration"

      assert_patch(index_live, ~p"/users/new")

      assert index_live
             |> form("#user_registration-form", user_registration: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_registration-form", user_registration: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users")

      html = render(index_live)
      assert html =~ "User registration created successfully"
      assert html =~ "some email"
    end

    test "updates user_registration in listing", %{conn: conn, user_registration: user_registration} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("#users-#{user_registration.id} a", "Edit") |> render_click() =~
               "Edit User registration"

      assert_patch(index_live, ~p"/users/#{user_registration}/edit")

      assert index_live
             |> form("#user_registration-form", user_registration: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_registration-form", user_registration: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users")

      html = render(index_live)
      assert html =~ "User registration updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes user_registration in listing", %{conn: conn, user_registration: user_registration} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("#users-#{user_registration.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#users-#{user_registration.id}")
    end
  end

  describe "Show" do
    setup [:create_user_registration]

    test "displays user_registration", %{conn: conn, user_registration: user_registration} do
      {:ok, _show_live, html} = live(conn, ~p"/users/#{user_registration}")

      assert html =~ "Show User registration"
      assert html =~ user_registration.email
    end

    test "updates user_registration within modal", %{conn: conn, user_registration: user_registration} do
      {:ok, show_live, _html} = live(conn, ~p"/users/#{user_registration}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User registration"

      assert_patch(show_live, ~p"/users/#{user_registration}/show/edit")

      assert show_live
             |> form("#user_registration-form", user_registration: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_registration-form", user_registration: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/users/#{user_registration}")

      html = render(show_live)
      assert html =~ "User registration updated successfully"
      assert html =~ "some updated email"
    end
  end
end
