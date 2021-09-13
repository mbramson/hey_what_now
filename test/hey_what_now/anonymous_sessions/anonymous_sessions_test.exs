defmodule HeyWhatNow.AnonymousSessions.AnonymousSessionsTest do
  use HeyWhatNow.DataCase, async: true

  alias HeyWhatNow.AnonymousSessions
  alias HeyWhatNow.AnonymousSessions.AnonymousSession
  alias HeyWhatNow.Factory

  describe "create_anonymous_session/1" do
    test "creates an anonymous session without any attrs" do
      assert {:ok, anonymous_session} = AnonymousSessions.create_anonymous_session()
      assert String.length(anonymous_session.id) == 36
    end
  end

  describe "get_anonymous_session/1" do
    test "returns an anonymous session" do
      anonymous_session = Factory.insert(:anonymous_session)

      returned_anonymous_session = AnonymousSessions.get_anonymous_session(anonymous_session.id)

      assert %AnonymousSession{} = returned_anonymous_session
      assert returned_anonymous_session.id == anonymous_session.id
    end

    test "returns nil if no anonymous session exists" do
      uuid = Ecto.UUID.generate()
      assert AnonymousSessions.get_anonymous_session(uuid) == nil
    end
  end
end
