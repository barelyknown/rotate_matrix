class MatrixRotator

  attr_reader :matrix

  def initialize(matrix)
    raise ArgumentError, "matrix has rows of uneven size" if _misshapen?(matrix)
    @matrix = matrix
  end

  def rotate
    processed = []
    matrix.each_with_index do |row, r|
      row.each_with_index do |value, c|
        while !processed.index([r,c])
          new_r, new_c = _calculate_new_coordinates(r, c)
          replaced_value = matrix[new_r][new_c]

          matrix[new_r][new_c] = value
          processed << [r,c]
          r, c = new_r, new_c
          value = replaced_value
        end
      end
    end
    matrix
  end

  def _misshapen?(matrix)
    matrix.map { |r| r.size }.uniq.size > 1
  end

  def _calculate_new_coordinates(row, col)
    return [row, col] if _is_center_square?(row, col)

    distance_traveled = 0
    new_rc = { r: row, c: col }
    direction_index = _starting_direction(row, col)
    while distance_traveled < _travel_distance
      axis, by = _directions[direction_index % 4]

      proposed = new_rc[axis] + by
      if proposed >= _min && proposed <= _max
        new_rc[axis] = proposed
        distance_traveled += 1
      else
        direction_index += 1
      end
    end

    [new_rc[:r], new_rc[:c]]
  end

  def _travel_distance
    matrix[0].size - 1
  end

  def _min
    0
  end

  def _max
    _travel_distance
  end

  def _starting_direction(row, col)
    row <= col ? 0 : 2
  end

  def _is_center_square?(row, col)
    [row, col] == [_max / 2.to_f, _max / 2.to_f]
  end

  def _directions
    @directions ||= [[:c, 1],[:r, 1],[:c, -1],[:r, -1]]
  end

end
