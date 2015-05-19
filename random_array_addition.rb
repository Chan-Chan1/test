#var = Array.new(3) {Array.new(3)}
#var.each_with_index do |v, row|
#  v.each_with_index do |v1, col|
#    var[row][col] = 10
#  end
#end
#
#var.each_with_index do |v, row|
#  v.each_with_index do |v1, col|
#    print var[row][col].to_s + " "
#  end
#  puts ""
#end

def print_matrix(mat)
  mat.each_with_index do |rows, r|
    rows.each_with_index do |cols, c|
      print mat[r][c].to_s + " "
    end
    puts ""
  end
  puts "----------------------------"
end

row = rand(2..3)
col = rand(2..3)

a_matrix=Array.new(row) {Array.new(col)}
b_matrix=Array.new(row) {Array.new(col)}
c_matrix=Array.new(row) {Array.new(col)}

a_matrix.each_with_index do |rows, r|
  rows.each_with_index do |cols, c|
    a_matrix[r][c] = rand(0..9)
    b_matrix[r][c] = rand(0..9)
  end
end
print_matrix(a_matrix)
print_matrix(b_matrix)
a_matrix.each_with_index do |rows, r|
  rows.each_with_index do |cols, c|
    c_matrix[r][c] = a_matrix[r][c] + b_matrix[r][c]
  end
end
print_matrix(c_matrix)

