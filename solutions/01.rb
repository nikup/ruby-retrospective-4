def series(name, number)
  if name == 'summed'
    return series('fibonacci', number) + series('lucas', number)
  end

  series_at_position(series_start(name), number)
end

def series_at_position(previous, number)
  if number == 1
    previous[0]
  else
    series_at_position([previous[1], previous[0] + previous[1]], number - 1)
  end
end

def series_start(name)
  start_at = {
    fibonacci:  [1, 1],
    lucas:      [2, 1],
  }

  start_at[name.to_sym]
end