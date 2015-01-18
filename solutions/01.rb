def series(name, number)
  case name
    when 'fibonacci' then generic_series([1, 1], number)
    when 'lucas' then generic_series([2, 1], number)
    when 'summed' then series('fibonacci', number) + series('lucas', number)
  end
end

def generic_series(previous, number)
  if number == 1
    previous[0]
  else
    generic_series([previous[1], previous[0] + previous[1]], number - 1)
  end
end