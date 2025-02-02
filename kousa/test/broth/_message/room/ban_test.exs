defmodule BrothTest.Message.Room.BanTest do
  use ExUnit.Case, async: true

  @moduletag :message

  alias Broth.Message.Room.Ban

  setup do
    {:ok, uuid: UUID.uuid4()}
  end

  describe "when you send a block message" do
    test "it populates userId", %{uuid: uuid} do
      assert {:ok,
              %{
                payload: %Ban{userId: ^uuid}
              }} =
               BrothTest.Support.Message.validate(%{
                 "operator" => "room:ban",
                 "payload" => %{"userId" => uuid}
               })

      # short form also allowed
      assert {:ok,
              %{
                payload: %Ban{userId: ^uuid}
              }} =
               BrothTest.Support.Message.validate(%{
                 "op" => "room:ban",
                 "p" => %{"userId" => uuid}
               })
    end

    test "omitting the userId is not allowed" do
      assert {:error, %{errors: %{userId: "can't be blank"}}} =
               BrothTest.Support.Message.validate(%{
                 "operator" => "room:ban",
                 "payload" => %{}
               })
    end
  end
end
