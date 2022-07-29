defmodule GenServerService do
  use GenServer

  @parking_lot %{
    "handicap" => %{0 => "", 1 => "", 2 => ""},
    "motor_cycle" => %{0 => "", 1 => "", 2 => "", 3 => "", 4 => ""},
    "car" => %{0 => "x", 1 => "", 2 => "", 3 => ""},
    "truck" => %{0 => ""}
  }

  def start_link() do
    GenServer.start_link(__MODULE__, @parking_lot)
  end

  def __init__(map) do
    {:ok, map}
  end

  def park(pid, row, column, value) do
    item_accessor = [row, column, value]
    GenServer.cast(pid, item_accessor)
  end

  def view_parking(pid) do
    GenServer.call(pid, :view_parking)
  end

  def move_from_parking(pid, row, column) do
    item = [row, column]
    GenServer.cast(pid, {:move, item})
  end

  def stop(pid) do
    GenServer.stop(pid, :normal, :infinity)
  end

  def terminate(_reason, _map) do
    :ok
  end

  def handle_cast({:move, item}, map) do
    [row, column] = item
    value = ""
    new_map = put_in(map[row][column], value)
    {:noreply, new_map}
  end

  def handle_cast(item, map) do
    [row, column, value] = item
    new_map = put_in(map[row][column], value)
    {:noreply, new_map}
  end

  def handle_call(:view_parking, from, map) do
    {:reply, map, map}
  end
end

defmodule ParkingLot do
  @moduledoc """
  x marks a parked vehicle
  """
  def find_parking(pid, type) do
    parking = pid |> GenServerService.view_parking()

    spaces =
      parking[type]
      |> Enum.filter(fn {_, v} -> v == "" end)
      |> Enum.map(fn {k, _} -> k end)

    case length(spaces) >= 1 do
      true ->
        available = spaces |> List.first()
        pid |> GenServerService.park(type, available, "x")
        pid |> GenServerService.view_parking()

      false ->
        "No more spaces available for " <> type
    end
  end

  def remove_from_parking(pid, type, parking_spot) do
    pid |> GenServerService.move_from_parking(type, parking_spot)
    pid |> GenServerService.view_parking()
  end
end
