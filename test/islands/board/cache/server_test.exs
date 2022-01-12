defmodule Islands.Board.Cache.ServerTest do
  use ExUnit.Case, async: true

  alias Islands.Board.Cache.Server

  doctest Server

  describe "Server.start_link/1" do
    @tag :islands_board_cache_server_test_1
    test "returns a tuple" do
      assert {:error, {:already_started, pid}} = Server.start_link(:ok)
      assert is_pid(pid) and pid == Process.whereis(Server)
    end
  end
end
