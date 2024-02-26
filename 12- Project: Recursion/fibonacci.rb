def fibs(n)
  return p [] if n == 0
  return p [0] if n == 1
  sequence = [0, 1]
  until sequence.length == n
    sequence << sequence[-2] + sequence[-1]
  end
  return p sequence

end

def fibs_rec(n, sequence = [0, 1])
  return p [] if n == 0
  return p [0] if n == 1

  return p sequence if n == sequence.length

  sequence << sequence[-1] + sequence[-2]
  fibs_rec(n, sequence)

end

fibs(8)
fibs_rec(20)
