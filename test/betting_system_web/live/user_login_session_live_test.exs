defmodule BettingSystemWeb.UserLoginSessionLiveTest do
  use BettingSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import BettingSystem.AuthFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_user_login_session(_) do
    user_login_session = user_login_session_fixture()
    %{user_login_session: user_login_session}
  end

  describe "Index" do
    setup [:create_user_login_session]

    test "lists all user_login_sessions", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/user_login_sessions")

      assert html =~ "Listing User login sessions"
    end

    test "saves new user_login_session", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/user_login_sessions")

      assert index_live |> element("a", "New User login session") |> render_click() =~
               "New User login session"

      assert_patch(index_live, ~p"/user_login_sessions/new")

      assert index_live
             |> form("#user_login_session-form", user_login_session: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_login_session-form", user_login_session: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_login_sessions")

      html = render(index_live)
      assert html =~ "User login session created successfully"
    end

    test "updates user_login_session in listing", %{conn: conn, user_login_session: user_login_session} do
      {:ok, index_live, _html} = live(conn, ~p"/user_login_sessions")

      assert index_live |> element("#user_login_sessions-#{user_login_session.id} a", "Edit") |> render_click() =~
               "Edit User login session"

      assert_patch(index_live, ~p"/user_login_sessions/#{user_login_session}/edit")

      assert index_live
             |> form("#user_login_session-form", user_login_session: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#user_login_session-form", user_login_session: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/user_login_sessions")

      html = render(index_live)
      assert html =~ "User login session updated successfully"
    end

    test "deletes user_login_session in listing", %{conn: conn, user_login_session: user_login_session} do
      {:ok, index_live, _html} = live(conn, ~p"/user_login_sessions")

      assert index_live |> element("#user_login_sessions-#{user_login_session.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_login_sessions-#{user_login_session.id}")
    end
  end

  describe "Show" do
    setup [:create_user_login_session]

    test "displays user_login_session", %{conn: conn, user_login_session: user_login_session} do
      {:ok, _show_live, html} = live(conn, ~p"/user_login_sessions/#{user_login_session}")

      assert html =~ "Show User login session"
    end

    test "updates user_login_session within modal", %{conn: conn, user_login_session: user_login_session} do
      {:ok, show_live, _html} = live(conn, ~p"/user_login_sessions/#{user_login_session}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User login session"

      assert_patch(show_live, ~p"/user_login_sessions/#{user_login_session}/show/edit")

      assert show_live
             |> form("#user_login_session-form", user_login_session: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#user_login_session-form", user_login_session: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/user_login_sessions/#{user_login_session}")

      html = render(show_live)
      assert html =~ "User login session updated successfully"
    end
  end
end
