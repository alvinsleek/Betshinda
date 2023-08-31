defmodule BettingSystemWeb.AccountManagementLiveTest do
  use BettingSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import BettingSystem.AccountsFixtures

  @create_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", msisdn: "some msisdn"}
  @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", msisdn: "some updated msisdn"}
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil, msisdn: nil}

  defp create_account_management(_) do
    account_management = account_management_fixture()
    %{account_management: account_management}
  end

  describe "Index" do
    setup [:create_account_management]

    test "lists all users", %{conn: conn, account_management: account_management} do
      {:ok, _index_live, html} = live(conn, ~p"/users")

      assert html =~ "Listing Users"
      assert html =~ account_management.email
    end

    test "saves new account_management", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("a", "New Account management") |> render_click() =~
               "New Account management"

      assert_patch(index_live, ~p"/users/new")

      assert index_live
             |> form("#account_management-form", account_management: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#account_management-form", account_management: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users")

      html = render(index_live)
      assert html =~ "Account management created successfully"
      assert html =~ "some email"
    end

    test "updates account_management in listing", %{conn: conn, account_management: account_management} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("#users-#{account_management.id} a", "Edit") |> render_click() =~
               "Edit Account management"

      assert_patch(index_live, ~p"/users/#{account_management}/edit")

      assert index_live
             |> form("#account_management-form", account_management: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#account_management-form", account_management: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users")

      html = render(index_live)
      assert html =~ "Account management updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes account_management in listing", %{conn: conn, account_management: account_management} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("#users-#{account_management.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#users-#{account_management.id}")
    end
  end

  describe "Show" do
    setup [:create_account_management]

    test "displays account_management", %{conn: conn, account_management: account_management} do
      {:ok, _show_live, html} = live(conn, ~p"/users/#{account_management}")

      assert html =~ "Show Account management"
      assert html =~ account_management.email
    end

    test "updates account_management within modal", %{conn: conn, account_management: account_management} do
      {:ok, show_live, _html} = live(conn, ~p"/users/#{account_management}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Account management"

      assert_patch(show_live, ~p"/users/#{account_management}/show/edit")

      assert show_live
             |> form("#account_management-form", account_management: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#account_management-form", account_management: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/users/#{account_management}")

      html = render(show_live)
      assert html =~ "Account management updated successfully"
      assert html =~ "some updated email"
    end
  end
end
